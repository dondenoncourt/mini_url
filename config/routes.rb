Rails.application.routes.draw do
  resources :short_urls, except: [:destroy, :update, :edit]
  get ':id', to: 'short_urls#show', as: :short
  root to: 'short_urls#new'
end
