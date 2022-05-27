ActiveAdmin.register Plan do
  actions :all, except: [:destroy]

  filter :name

  form do |f|
    inputs "Details" do
      f.input :name
    end

    f.inputs do
      f.has_many :incomes, heading: false, allow_destroy: true do |i|
        i.input :description
        i.input :amount
        i.input :type, as: :select, collection: ['quarterly', 'monthly']
      end
    end
    f.inputs do
      f.has_many :expenses, heading: false, allow_destroy: true do |i|
        i.input :description
        i.input :amount
        i.input :type, as: :select, collection: ['quarterly', 'monthly']
      end
    end
    f.actions
  end

  show do
    table_for plan.cumulative_profits do
      column(:month)
      column(:expenses)
      column(:incomes)
      column(:profit)
      column(:cumulative_profit)
    end
  end
end
