class Plan < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :incomes, dependent: :destroy

  accepts_nested_attributes_for :expenses, :incomes
end
