Rails.application.routes.draw do
  root "tops#top"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :reviews, only: %i[index new create show]
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
