class Category < ApplicationRecord
  has_many :transactions, dependent: :restrict_with_error

  enum :kind, { expense: "expense", income: "income" }

  validates :name, :kind, presence: true
  validates :kind, inclusion: { in: kinds.keys }
end
