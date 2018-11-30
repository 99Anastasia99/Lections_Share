Rails.application.routes.draw do
 scope '/:locale', locale: /#{I18n.available_locales.join('|')}/ do
  resources :lections do
    post 'comments', to: "comments#create"
    collection do
      get :search
    end
  end

  resources :users, only: [:update, :show, :destroy]
  get 'tagged', to: "lections#tagged"
  root to: "pages#home"
end

 root to: redirect("/#{I18n.default_locale}", status: 302)
  devise_for :users
  get 'users/edit_multiple'
  get 'ratings/create'
  get 'application/set_locale_cookie'
  resources :tags
  post 'comments/like_dislike'
end
