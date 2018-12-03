class User < ApplicationRecord
  acts_as_liker
  update_index('lections#lection') { lections }
  has_many :comments, dependent: :destroy
  has_many :lections, dependent: :destroy
  has_many :ratings, dependent: :destroy
  validates :username,length: {maximum: 20},presence: true, uniqueness: { scope: :username, message: "must be unique for each user" },allow_nil: false

  before_create :confirmation_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,:lockable,:omniauthable, omniauth_providers: [:facebook, :vkontakte, :twitter]

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
end
end
