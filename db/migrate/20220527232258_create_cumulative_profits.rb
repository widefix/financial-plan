class CreateCumulativeProfits < ActiveRecord::Migration[7.0]
  def change
    create_view :cumulative_profits
  end
end
