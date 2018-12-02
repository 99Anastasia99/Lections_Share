class User < ApplicationRecord
  acts_as_liker
  update_index('lections#lection') { lections }
  validates :username,presence: true,length: {maximum: 30},on: :create,allow_nil: false
  has_many :comments, dependent: :destroy
  has_many :lections, dependent: :destroy
  has_many :ratings, dependent: :destroy
  before_create :confirmation_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,:lockable,:confirmable
end
