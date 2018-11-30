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
    @user.each do  |user_to_admin|
      user_to_admin.admin=true
      user_to_admin.save
    end
  end

  def make_user
    @user.each do  |user_to_admin|
      user_to_admin.admin=false
      user_to_admin.save
    end
  end

  def edit_multiple
    @user=User.where(id: params[:user_ids])
    if params_edit == t('common.destroy')
      @user.destroy_all
    elsif params_edit == t('common.lock')
      @user.each {|user_to_lock| user_to_lock.lock_access! }
    elsif params_edit == t('common.unlock')
      @user.each {|user_to_unlock| user_to_unlock.unlock_access!} 
    elsif params_edit == t('admin_panel.up')
      @user = make_admin
    elsif params_edit == t('admin_panel.down')
      @user = make_user
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
