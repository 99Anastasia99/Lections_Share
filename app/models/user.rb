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

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      return registered_user if registered_user
        user = User.new(
        username:auth.extra.raw_info.name,
        provider:auth.provider,
        uid:auth.uid,
        email:auth.info.email,
        password:Devise.friendly_token[0,20]
      )
      user.skip_confirmation!
      user.save
      user
    end
  end
end
