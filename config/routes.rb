Rails.application.routes.draw do
  resources :scrape_results
  root :to => 'scrape_results#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
