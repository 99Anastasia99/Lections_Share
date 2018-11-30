class RatingsController < ApplicationController
  before_action :set_lection, except: [:destroy, :like_dislike]
  before_action :authenticate_user!

  def create
    if @lection.ratings.where(user: current_user)
      @rating = edit
    else
      @rating = create_new
    end
    @rating.user = current_user
    @rating.save
    respond_to do |format|
      format.js
    end
  end

  def create_new
    @rating = @lection.ratings.new(rating: params[:rating], lection_id: params[:lection_id])
  end

  def edit
     @lection.ratings.where(user: current_user).destroy_all
    @rating = @lection.ratings.new(rating: params[:rating], lection_id: params[:lection_id])
  end

  def set_lection
    @lection = Lection.find(params[:lection_id])
  end


end
