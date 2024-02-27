Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
  resources :posts
  root 'home#index'
  get 'home/show'
  get '/search' , to: "posts#search"
  get '/applied_jobs/:id/apply', to: "applied_jobs#apply", as: :apply
  get '/applied_jobs/:id/:user_id', to: "applied_jobs#selected", as: :selected
  get '/applied_jobs/:id/:user_id/reject', to: "applied_jobs#reject", as: :rejected
  get '/show_applies', to: "applied_jobs#show_applies"
  get '/show_applies/:id' , to: "applied_jobs#show_applies"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
