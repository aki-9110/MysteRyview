Rails.application.routes.draw do
  root "tops#top"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :reviews do
    resources :comments, only: %i[create edit destroy], shallow: true

    member do
      get :spoiler
    end

    collection do
      get :likes
    end
  end

  resources :likes, only: %i[create destroy]

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
