class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "comments",( {
      comment: render_comment(comment),
      lection_id: data.lection.id
    })
  end

  private
  def render_comment(comment)
    CommentsController.render( partial: 'comments/comment', locals: { comment: comment })
  end

end
