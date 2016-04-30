Rails.application.routes.draw do

  get 'exercises/index'

  devise_for :users
  root to: 'dashboard#index'

  resources :users do
    resources :exercises
  end

end
