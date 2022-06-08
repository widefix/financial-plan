# Financial Plan on Rails

This is a Rails application demo that was described in this [article](https://railsguides.net/2022-05-18-financial-plan-on-rails/).

It shows how to combine all these things together to make a financial planning web application in a moment:

- [Rails](https://rubyonrails.org/)
- [ActiveAdmin](https://activeadmin.info/)
- [Scenic](https://github.com/scenic-views/scenic)

The application is [deployed on Heroku](https://personal-financial-plan.herokuapp.com/).

## Implementation notes

It demonstrates how heavy calculations can be defined on DB level instead of application one. That makes application faster and robuster.
Look at the "virtual model" `CumulativeProfit` [here](https://github.com/widefix/financial-plan/blob/02fcf7c5093513eadc8aa8491926953712a3d352/app/models/cumulative_profit.rb).
This model uses `cumulative_profits` [view](https://github.com/widefix/financial-plan/blob/main/db/schema.rb#L72-L80) as a source feed.
The model has all reading facilities like a "traditional" model, expect it can't write data.
