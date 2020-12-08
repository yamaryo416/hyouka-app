Rails.application.routes.draw do
  devise_for :therapists, controllers: {
    sessions: "therapists/sessions",
    registrations: "therapists/registrations"
  }

  devise_scope :therapist do
    root to: "therapists/sessions#new"
    get "/signup", to: "therapists/registrations#new"
    post "/login", to: "therapists/sessions#create"
    delete "/logout", to: "therapists/sessions#destroy"
  end

  get 'static_pages/about'
  resources :patients do
    resources :sias_scales
    resource :rom_scales
    resource :mmt_scales
    resource :fbs_scales
    resource :brs_scales
    resource :mas_scales
    resource :tendon_reflex_scales
    resource :tactile_scales
    resource :bathyesthesia_scales
    resources :nrs_scales
    resources :hdsr_scales
    resources :bestest_scales
    resources :fact_scales
  end
end
