class CreateMonths < ActiveRecord::Migration[7.0]
  def change
    create_view :months
  end
end
