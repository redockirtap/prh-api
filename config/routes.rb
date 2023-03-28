# frozen_string_literal: true

Rails.application.routes.draw do
  root 'companies#index'
  get '/postal_codes/:postal_code/companies',
      to: 'companies#show', param: :postal_code, defaults: { format: 'json' }
end
