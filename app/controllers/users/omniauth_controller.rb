class Users::OmniauthController < ApplicationController
  def facebook
  @user = User.from_omniauth(request.env['omniauth.auth'])
  if @user.persisted?
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  else
    flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end

def twitter
  @user = User.from_omniauth(request.env['omniauth.auth'])
  if @user.persisted?
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
  else
    flash[:error] = 'There was a problem signing you in through Twitter. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end

def vkontakte
  @user = User.from_omniauth(request.env['omniauth.auth'])
  if @user.persisted?
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Vkontakte') if is_navigational_format?
  else
    flash[:error] = 'There was a problem signing you in through Vkontakte. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end

def failure
  flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
  redirect_to new_user_registration_url
end

end
