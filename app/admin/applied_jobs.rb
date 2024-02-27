ActiveAdmin.register AppliedJob do
  permit_params :user_id, :post_id, :status
end
