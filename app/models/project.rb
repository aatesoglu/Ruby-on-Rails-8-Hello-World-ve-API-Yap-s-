class Project < ApplicationRecord
  # Enums - Rails 7+ syntax
  enum :status, { draft: 0, active: 1, completed: 2, archived: 3 }

  # Associations
  belongs_to :user
  has_many :surveys, dependent: :destroy
  has_many :analyses, dependent: :destroy
  has_many :credit_transactions, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :status, presence: true
  validates :credit_allocated, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :credit_used, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Callbacks
  before_validation :set_default_credits, on: :create

  # Methods
  def use_credits(amount, description = nil)
    return false if remaining_credits < amount
    return false unless user.can_afford?(amount)

    transaction do
      increment!(:credit_used, amount)
      user.decrement!(:credits_balance, amount)
      
      credit_transactions.create!(
        user: user,
        transaction_type: :usage,
        amount: -amount,
        balance_after: user.credits_balance,
        description: description || "Project usage"
      )
    end
    
    true
  rescue => e
    Rails.logger.error("Credit usage failed: #{e.message}")
    false
  end

  def remaining_credits
    (credit_allocated || 0) - (credit_used || 0)
  end

  def credit_usage_percentage
    return 0 if credit_allocated.nil? || credit_allocated.zero?
    ((credit_used || 0).to_f / credit_allocated * 100).round(2)
  end

  private

  def set_default_credits
    self.credit_allocated ||= 0
    self.credit_used ||= 0
  end
end