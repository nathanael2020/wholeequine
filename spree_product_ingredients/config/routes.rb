Spree::Core::Engine.routes.draw do

  namespace :admin do
    resources :ingredients
    resources :products do
      resources :product_ingredients
    end
  end

  resources :charts
  resources :ingredients, only: [:index]

end
