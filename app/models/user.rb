class User < ActiveRecord::Base
  has_many :jobs, inverse_of: :user
  accepts_nested_attributes_for :jobs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
