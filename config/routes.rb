HealthyHabits::Application.routes.draw do
  resources :products
  resources :contacts
  resources :testimonials
  resources :pages

  match '/products_page', :to=>'products#products_page'

  authenticated :user do
    root :to => "pages#show", :id => 'home'
  end
  root :to => "pages#show", :id => 'home'
  devise_for :users
  resources :users

  match '/cleanse_notice', :to => 'contacts#cleanse_notice'
end