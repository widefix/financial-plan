class Plan < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :cumulative_profits, -> { order(:month) }

  accepts_nested_attributes_for :expenses, :incomes, allow_destroy: true
end
