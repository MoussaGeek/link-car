Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
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
  # Define the route for Active Storage blobs and their variations
  # This route should come before the catch-all route
  get '/rails/active_storage/blobs/:signed_id/:filename/*variation',
      to: 'active_storage/representations#show'

  direct :representation do |representation|
    route_for(:rails_representation, representation)
  end

  # The catch-all route for unmatched paths, excluding Active Storage paths
  # This route should only match paths that aren't used by Active Storage
  get '*path', to: 'application#render_404', constraints: ->(req) { !req.path.start_with?('/rails/active_storage') }
end