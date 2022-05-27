select plan_id, month, expenses, incomes, profit, sum(profit) over (order by month) cumulative_profit from monthly_profits;
