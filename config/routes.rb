Rails.application.routes.draw do
  namespace :v1 do
    resources :genres
    resources :comments, only: [ :show, :update, :destroy ]
    resources :movies do
      resources :comments, only: [ :index, :create ]
      collection do
        get :coming_soon
        get :featured
      end
    end
  end
end
