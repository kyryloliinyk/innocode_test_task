# frozen_string_literal: true

Rails.application.routes.draw do
  # ....
  resources :routes, only: :create
  # ....
end
