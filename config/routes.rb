HealthyHabits::Application.routes.draw do
  resources :products
  resources :contacts
  resources :testimonials
  resources :pages

  match '/products_page', :to=>'products#products_page'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end