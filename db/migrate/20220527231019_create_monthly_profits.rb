class CreateMonthlyProfits < ActiveRecord::Migration[7.0]
  def change
    create_view :monthly_profits
  end
end
