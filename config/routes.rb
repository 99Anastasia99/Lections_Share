Rails.application.routes.draw do
 scope '/:locale', locale: /#{I18n.available_locales.join('|')}/ do
  resources :lections do
    post 'comments', to: "comments#create"
    collection do
      get :search
    end
  end
  devise_for :users
  resources :users, only: [:update, :show, :destroy]
  get 'tagged', to: "lections#tagged"
  root to: "pages#home"
end

 root to: redirect("/#{I18n.default_locale}", status: 302)
  get 'users/edit_multiple'
  get'users/current_user_theme'
  get 'ratings/create'
  resources :tags
  post 'comments/like_dislike'
end
