Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root "pages#home"

  devise_for :offices, controllers: { registrations: "registrations" }

  get "/dashboard", to: "dashboard#index", as: "dashboard"
  post "/switch/:role", to: "dashboard#switch", as: "switch"

  resources :document_types, only: [:index, :show, :create, :update, :destroy]
  resources :office_staffs, only: [:index, :create, :update, :destroy]
  resources :documents, only: [:index, :show, :create, :update, :destroy]
  resources :document_routes, only: [:create] do
    put :receive, on: :member
    put :release, on: :member
    put :reject, on: :member
    put :complete, on: :member
  end

  namespace :admin do
    resources :offices, only: [:index, :update, :destroy] do
      patch :toggle_admin_privilege, on: :member
    end
    resources :document_types, only: [:index, :show, :create, :update, :destroy]
    resources :documents, only: [:index, :show]
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
