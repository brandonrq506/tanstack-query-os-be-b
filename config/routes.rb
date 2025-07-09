Rails.application.routes.draw do
  namespace :v1 do
    resources :genres
    resources :movies do
      collection do
        get :coming_soon
        get :featured
      end
    end
  end
end