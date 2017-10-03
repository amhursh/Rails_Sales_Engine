Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
      	get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
    	resources :transactions, only: [:index, :show]
      resources :merchants, only: [:index, :show] 
      resources :invoices, only: [:index, :show]
    end
  end
end
