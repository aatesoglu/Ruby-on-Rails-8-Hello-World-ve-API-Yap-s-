class ScaleItem < ApplicationRecord
  # Enums - Rails 7+ syntax
  enum :item_type, { likert: 0, multiple_choice: 1, open_ended: 2, boolean: 3 }

  # Associations
  belongs_to :scale

  # Validations
  validates :content, presence: true
  validates :item_type, presence: true
  validates :order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order, uniqueness: { scope: :scale_id }

  # Scopes
  default_scope { order(order: :asc) }

  # Methods
  def likert?
    item_type == "likert"
  end

  def requires_options?
    ["likert", "multiple_choice"].include?(item_type)
  end
end