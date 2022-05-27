class Expense < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :plan
end
