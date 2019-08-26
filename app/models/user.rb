class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :todos
  has_and_belongs_to_many :projects

  validates :email, :name, :password, presence: true
  validates :email, uniqueness: true

  scope :developers, ->{ where(is_admin: false) }

  def full_name
    name.titleize
  end

end
