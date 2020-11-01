Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  devise_scope :user do
    get "/signup", to: "users/registrations#new"
    get "/login", to: "users/sessions#new"
    post "/login", to: "users/sessions#create"
    delete "/logout", to: "users/sessions#destroy"
  end

  root to: "static_pages#home"
  get 'static_pages/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
