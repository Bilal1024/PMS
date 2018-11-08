# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users do
    member do
      get :profile
    end
  end

  root 'projects#index'

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
  end
end
