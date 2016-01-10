Rails.application.routes.draw do

 devise_for :users, controllers: {registrations: 'users/registrations'}

 resources :wikis

 resources :charges, only: [:new, :create] do
   get 'status_changing', on: :collection
 end

 mount StripeEvent::Engine, at: 'http://www.example.com/'

 root to: 'wikis#index'

end


#Ensure you have overridden routes for generated controllers in your routes.rb.
 #For example:

   #Rails.application.routes.draw do
    # devise_for :users, controllers: {
       #sessions: 'users/sessions'
    # }
   #end
