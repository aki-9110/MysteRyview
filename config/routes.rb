Rails.application.routes.draw do
  root "tops#top"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    password: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :reviews do
    resources :comments, only: %i[create edit destroy], shallow: true

    member do
      get :spoiler
    end

    collection do
      get :autocomplete
    end
  end

  resources :likes, only: %i[create destroy]

  resource :profile, only: %i[edit show update destroy] do
    collection do
      get :my_reviews
      get :my_likes
      get :my_notifications
      get :notification
      get :read_notification
    end
  end

  namespace :step_form do
    resources :books, only: %i[new create]
    resources :non_spoilers, only: %i[new create]
    resources :spoilers, only: %i[new create]
    resources :additional_infos, only: %i[new create]
  end


  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
