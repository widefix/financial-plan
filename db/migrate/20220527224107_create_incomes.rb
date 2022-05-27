class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.integer :amount
      t.string :description
      t.string :type
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
