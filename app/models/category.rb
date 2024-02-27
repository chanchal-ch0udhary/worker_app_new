class Category < ApplicationRecord
    has_many :posts,dependent: :destroy
    # has_many :applied_jobs,dependent: :destroy
    validates :name, presence: true

    def self.ransackable_associations(auth_object = nil)
        ["applied_jobs", "posts"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value","category_id", "name", "updated_at"]
    end
    
end
