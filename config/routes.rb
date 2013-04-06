HealthyHabits::Application.routes.draw do
  resources :contacts


  resources :testimonials


  resources :pages


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end