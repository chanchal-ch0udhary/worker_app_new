class User < ApplicationRecord
  
  has_many :posts,dependent: :destroy
  
  has_many :applied_jobs,dependent: :destroy

  has_one_attached :image,:dependent => :destroy

  validates :name, :email, :address, :role, presence: true
  validates :phone_no, presence: {message: "Please enter only numbers!"}, numericality: true, length: { in:10..12}


  enum role: {'worker' =>'worker','contractor' => 'contractor'}

  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def contractor?
    role == 'contractor'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "bio", "created_at", "email", "encrypted_password", "id", "id_value", "name", "phone_no", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["applied_jobs", "image_attachment", "image_blob", "posts"]
  end

end
