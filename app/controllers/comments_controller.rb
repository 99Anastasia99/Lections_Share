class CommentsController < ApplicationController
  before_action :set_lection, except: [:destroy, :like_dislike]
  before_action :authenticate_user!

  def create
    @comment = @lection.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def like_dislike
    current_user.toggle_like!(Comment.find(params[:comment]))
    @comment_id = params[:comment]
    @likes_counter = Comment.find(params[:comment]).likers_count
    @user_liked = Comment.find(params[:comment]).liked_by?(current_user)
    respond_to do |format|
      format.js {
        render :template => 'comments/like_dislike.js.erb'
      }
    end
  end
  # def destroy
  #   @comment = @lection.comments.find(params[:id])
  #   @comment_id = @comment.id
  #   @comment.destroy
  # end

  private
  def comment_params
    params.require(:comment).permit (:body)
  end

  def set_lection
    @lection = Lection.find(params[:lection_id])
  end

end
