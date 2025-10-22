class Response < ApplicationRecord
  # Associations
  belongs_to :survey

  # Validations
  validates :participant_id, presence: true
  validates :response_data, presence: true

  # Scopes
  scope :completed, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }

  # Methods
  def completed?
    completed_at.present?
  end

  def mark_completed!
    update!(completed_at: Time.current)
  end

  def duration_in_minutes
    return nil unless completed_at.present?
    ((completed_at - created_at) / 60.0).round(2)
  end
end