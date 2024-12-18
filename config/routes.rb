Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :raclettes do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, except: [:new, :create] do
    member do
      patch :decline
      patch :accept
    end
  end
  # patch "bookings/:id", to: "bookings#accept", as: :accept_booking

  get :my_bookings, to: "bookings#my_bookings", as: "my_bookings"
  get :dashboard, to: "pages#dashboard", as: "dashboard"
end
