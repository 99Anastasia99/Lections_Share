class Comment < ApplicationRecord
  acts_as_likeable
  update_index('lections#lection') { lection }
  belongs_to :user, optional: true
  belongs_to :lection, optional: true
  validates :body, length: {maximum: 400},on: :create,allow_nil: false

  after_create_commit {
    CommentBroadcastJob.perform_later(self)
  }

end
