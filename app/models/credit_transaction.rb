class CreditTransaction < ApplicationRecord
  # Enums - Rails 7+ syntax
  enum :transaction_type, { purchase: 0, usage: 1, refund: 2, bonus: 3 }

  # Associations
  belongs_to :user
  belongs_to :project, optional: true

  # Validations
  validates :transaction_type, presence: true
  validates :amount, presence: true, numericality: true
  validates :balance_after, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Scopes
  scope :purchases, -> { where(transaction_type: :purchase) }
  scope :usages, -> { where(transaction_type: :usage) }
  scope :recent, -> { order(created_at: :desc) }

  # Methods
  def credit_added?
    amount.positive?
  end

  def credit_deducted?
    amount.negative?
  end
end