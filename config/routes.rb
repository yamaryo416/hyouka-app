Rails.application.routes.draw do
  devise_for :therapists, controllers: {
    sessions: "therapists/sessions",
    registrations: "therapists/registrations"
  }

  devise_scope :therapist do
    get "/signup", to: "therapists/registrations#new"
    get "/login", to: "therapists/sessions#new"
    post "/login", to: "therapists/sessions#create"
    delete "/logout", to: "therapists/sessions#destroy"
  end

  root to: "static_pages#home"
  get 'static_pages/about'
  resources :patients do
    resource :sias_scales
  end
end
