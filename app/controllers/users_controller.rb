class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  respond_to :html, :json

  def show
    @user = User.find(params[:id])
    @lections= @user.lections.order(params_sort + " " + params_direction)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
      @user = User.find(params[:id])
  end

  def make_admin
      @user.admin=true
      @user.save
  end

  def make_user
     @user.admin=false
     @user.save
    end

   def edit_multiple
     if params_edit == "Delete"
       User.where(id: params[:user_ids]).destroy_all
     elsif params_edit == "Lock"
       User.where(id: params[:user_ids]).each do |user_to_lock|
         user_to_lock.lock_access!
       end
     elsif params_edit == "Unlock"
       User.where(id: params[:user_ids]).each do |user_to_unlock|
         user_to_unlock.unlock_access!
       end
     end
   end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def params_edit
  params[:commit]
  end

  def params_sort
  params[:sort]||"title"
  end

  def params_direction
    params[:direction]||"asc"
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"

  end

end
