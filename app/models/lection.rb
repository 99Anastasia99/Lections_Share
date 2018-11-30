class Lection < ApplicationRecord
  update_index('lections#lection') { self }
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  acts_as_taggable_on :tags
  belongs_to :user, optional: true
  validates :title,presence: true, uniqueness: { scope: :user_id, message: "must be unique for each of your posts" }
  validates :body,presence: true,length: {maximum: 1500},on: :create,allow_nil: false

  def current_user_rating current_user
    if current_user_rating = self.ratings.find_by(user_id: current_user.id)
      return current_user_rating.rating.to_i
    else
      return 0
    end
  end

  def average_rate
    if self.ratings.to_i > 2
      self.ratings.to_i.each do |t|
        average_rate=(average_rate.to_i + t)/2
        return average_rate
    end
  end

end
