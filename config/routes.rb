# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :bands do
    resources :band_users, except: %i[edit update] do
      post 'transfer-ownership', on: :member, to: 'band_users#transfer_ownership'
    end

    resources :songs
  end

  # Defines the root path route ("/")
  root 'bands#index'
end
