HealthyHabits::Application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, :at => '/shopping'

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

  devise_scope :user do
    get '/login', :to => "devise/sessions#new"
    get '/signup', :to => "devise/registrations#new"
    post '/users/sign_out' => 'devise/sessions#destroy'
    post '/logout' => 'devise/sessions#destroy'
  end

  match '/cleanse_notice', :to => 'contacts#cleanse_notice'
  match '/microscopy_notice', :to => 'contacts#microscopy_notice'
end