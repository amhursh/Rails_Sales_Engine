Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end
      resources :customers, only: [:index, :show]

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#index'
        get '/:id/item', to: 'item#index'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :invoices do
      	get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/customer', to: 'customer#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/merchant', to: 'merchant#index'
        get '/:id/transactions', to: 'transactions#index'
      end
      resources :invoices, only: [:index, :show]


      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'top_revenue#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#index'
        get '/:id/revenue', to: 'revenue#index'
      end
      resources :items, only: [:index, :show]

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/revenue', to: 'revenue_by_date_all#show'
        get '/most_revenue', to: 'top_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/revenue', to: 'revenue#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/:id/customers_with_pending_invoices', to: 'pending_customers#index'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoices#show'
      end
      resources :transactions, only: [:index, :show]

    end
  end
end
