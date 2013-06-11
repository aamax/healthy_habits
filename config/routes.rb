HealthyHabits::Application.routes.draw do
  resources :testimonials
  resources :pages

  match '/products_page', :to=>'products#products_page'

  authenticated :user do
    root :to => "pages#show", :id => 'home'
  end
  root :to => "pages#show", :id => 'home'

  devise_for :users
  resources :users

  devise_scope :user do
    get '/login', :to => "devise/sessions#new"
    get '/signup', :to => "devise/registrations#new"
    post '/users/sign_out' => 'devise/sessions#destroy'
    post '/logout' => 'devise/sessions#destroy'
  end

  match '/cleanse_notice', :to => 'contacts#cleanse_notice'
  match '/microscopy_notice', :to => 'contacts#microscopy_notice'
end