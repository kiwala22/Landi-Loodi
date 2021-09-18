Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admins,
             controllers: {
                 sessions: 'api/admins/sessions'
             }

  namespace :api do
    match 'admin-info' => 'home#index', via: [:get]
    resources :tenants
    resources :rentals
    resources :payments
    resources :contracts
  end
end
