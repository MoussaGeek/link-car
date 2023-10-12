Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    post 'users/admin_sign_in', to: 'users/sessions#new_admin'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :cars
  resources :parkings
  resources :chauffeurs
  resources :rentals
  resources :users, except: [:new]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  get '/rails/active_storage/blobs/:signed_id/:filename/*variation',
      to: 'active_storage/representations#show'

  direct :representation do |representation|
    route_for(:rails_representation, representation)
  end

  get '*path', to: 'application#render_404', constraints: ->(req) { !req.path.start_with?('/rails/active_storage') }
end