class AppliedJob < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "post_id", "status", "updated_at", "user_id"]
  end

end
