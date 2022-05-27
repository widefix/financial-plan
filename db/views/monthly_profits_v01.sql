select
  p.id plan_id,
  m.month,
  me.amount + qe.amount expenses,
  mi.amount + qi.amount incomes,
  (mi.amount + qi.amount) - (me.amount + qe.amount) profit
from plans p
join months m on true
join lateral (select coalesce(sum(amount), 0) amount from expenses where plan_id = p.id and type = 'monthly') me on true
join lateral (select coalesce(sum(amount), 0) amount from expenses where plan_id = p.id and type = 'quarterly' and month % 3 = 0) qe on true
join lateral (select coalesce(sum(amount), 0) amount from incomes where plan_id = p.id and type = 'monthly') mi on true
join lateral (select coalesce(sum(amount), 0) amount from incomes where plan_id = p.id and type = 'quarterly' and month % 3 = 0) qi on true
group by p.id, m.month, me.amount, qe.amount, mi.amount, qi.amount;
