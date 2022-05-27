ActiveAdmin.register Plan do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    inputs "Details" do
      f.input :name
    end

    f.inputs do
      f.has_many :incomes, heading: false, allow_destroy: true do |i|
        i.input :description
        i.input :amount
        i.input :type, as: :select, collection: ['quaterly', 'monthly']
      end
    end
    f.inputs do
      f.has_many :expenses, heading: false, allow_destroy: true do |i|
        i.input :description
        i.input :amount
        i.input :type, as: :select, collection: ['quaterly', 'monthly']
      end
    end
    f.actions
  end
end
