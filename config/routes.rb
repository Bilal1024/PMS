# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'

  devise_for :users do
    member do
      get :profile
    end
  end

  namespace :admin do
    resources :users do
      member do
        patch :toggle_active
      end
    end

    resources :clients

    resources :projects do
      resources :payments
      resources :time_logs
    end
  end

  resources :clients

  resources :projects do
    resources :payments
    resources :time_logs
    resources :comments
  end
end
