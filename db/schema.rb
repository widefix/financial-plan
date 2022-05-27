# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_27_232258) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.integer "amount"
    t.string "description"
    t.string "type"
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_expenses_on_plan_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "amount"
    t.string "description"
    t.string "type"
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_incomes_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expenses", "plans"
  add_foreign_key "incomes", "plans"

  create_view "months", sql_definition: <<-SQL
      SELECT month.month
     FROM generate_series(1, 12) month(month);
  SQL
  create_view "monthly_profits", sql_definition: <<-SQL
      SELECT p.id AS plan_id,
      m.month,
      (me.amount + qe.amount) AS expenses,
      (mi.amount + qi.amount) AS incomes,
      ((mi.amount + qi.amount) - (me.amount + qe.amount)) AS profit
     FROM (((((plans p
       JOIN months m ON (true))
       JOIN LATERAL ( SELECT COALESCE(sum(expenses.amount), (0)::bigint) AS amount
             FROM expenses
            WHERE ((expenses.plan_id = p.id) AND ((expenses.type)::text = 'monthly'::text))) me ON (true))
       JOIN LATERAL ( SELECT COALESCE(sum(expenses.amount), (0)::bigint) AS amount
             FROM expenses
            WHERE ((expenses.plan_id = p.id) AND ((expenses.type)::text = 'quarterly'::text) AND ((m.month % 3) = 0))) qe ON (true))
       JOIN LATERAL ( SELECT COALESCE(sum(incomes.amount), (0)::bigint) AS amount
             FROM incomes
            WHERE ((incomes.plan_id = p.id) AND ((incomes.type)::text = 'monthly'::text))) mi ON (true))
       JOIN LATERAL ( SELECT COALESCE(sum(incomes.amount), (0)::bigint) AS amount
             FROM incomes
            WHERE ((incomes.plan_id = p.id) AND ((incomes.type)::text = 'quarterly'::text) AND ((m.month % 3) = 0))) qi ON (true))
    GROUP BY p.id, m.month, me.amount, qe.amount, mi.amount, qi.amount;
  SQL
  create_view "cumulative_profits", sql_definition: <<-SQL
      SELECT monthly_profits.plan_id,
      monthly_profits.month,
      monthly_profits.expenses,
      monthly_profits.incomes,
      monthly_profits.profit,
      sum(monthly_profits.profit) OVER (ORDER BY monthly_profits.month) AS cumulative_profit
     FROM monthly_profits;
  SQL
end
