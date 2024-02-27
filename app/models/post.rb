class Post < ApplicationRecord
  paginates_per 2
  belongs_to :user
  belongs_to :category
  
  has_many :applied_jobs,dependent: :destroy

  has_one_attached :post_image,:dependent => :destroy

  validates  :name, :description, :vacancy, :salary, :qualification, presence: true
  validates :vacancy,:salary, :numericality => { :greater_than => 0 },on: :create

  def self.ransackable_associations(auth_object = nil)
    ["applied_jobs", "category", "post_image_attachment", "post_image_blob", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "created_at", "id", "id_value", "name","description","vacancy","salary","qualification", "record_id", "record_type"]
  end

end
