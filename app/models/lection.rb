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

  def average_rating
    if self.ratings.count > 1
      rating_sum = 0
      self.ratings.pluck(:rating).each { |t| rating_sum += t }
      average_rate = rating_sum.to_f / self.ratings.count.to_f
      self.update(:average_rate => average_rate)
      return average_rate
    end
  end

end
