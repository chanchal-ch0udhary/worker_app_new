ActiveAdmin.register Post do
  permit_params :name, :description, :vacancy, :salary, :qualification, :user_id, :category_id
end
