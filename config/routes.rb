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
    member do
      resources :bookings, only: [:new, :create]
    end
  end

  get :my_raclettes, to: "raclettes#my_raclettes", as: "my_raclettes"

  resources :bookings, except: [:new, :create] do
    member do
      patch :accept
      patch :decline
    end
  end

  get :my_bookings, to: "bookings#my_bookings", as: "my_bookings"
end
