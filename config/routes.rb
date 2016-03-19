Rails.application.routes.draw do

  # Override registrations controller so we can manually set the role to 'Member'
  devise_for :users, controllers: {
    registrations: "devise_customisations/registrations",
    sessions: "devise_customisations/sessions"
  }

  resources :home, only: :index
  root to: "home#index"

  namespace :admin do
    resources :dashboard, only: :index
    resources :members
    resources :admins
  end

  namespace :member do
    resources :dashboard, only: :index
  end

end
