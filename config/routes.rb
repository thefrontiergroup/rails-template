Rails.application.routes.draw do

  # Override registrations controller so we can manually set the role to 'Member'
  devise_for :users, controllers: {
    registrations: "devise_customisations/registrations",
    passwords: "devise_customisations/passwords",
    sessions: "devise_customisations/sessions"
  }

  resources :home, only: :index
  root to: "home#index"

  namespace :admin do
    resources :dashboard, only: :index
    resources :members
    resources :admins
  end

  get "dashboard", to: "dashboard#index"

end
