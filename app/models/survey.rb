class Survey < ApplicationRecord
  # Enums - Rails 7+ syntax
  enum :distribution_mode, { link: 0, email: 1, panel: 2 }
  enum :status, { draft: 0, active: 1, paused: 2, completed: 3 }

  # Associations
  belongs_to :project
  belongs_to :scale
  has_many :responses, dependent: :destroy
  has_many :analyses, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :distribution_mode, presence: true
  validates :status, presence: true
  validate :end_date_after_start_date

  # Methods
  def response_count
    responses.where.not(completed_at: nil).count
  end

  def completion_rate
    total = responses.count
    return 0 if total.zero?
    
    completed = responses.where.not(completed_at: nil).count
    (completed.to_f / total * 100).round(2)
  end

  def active?
    status == "active" && 
    (start_date.nil? || start_date <= Date.current) &&
    (end_date.nil? || end_date >= Date.current)
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    
    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end