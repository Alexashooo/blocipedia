Rails.application.routes.draw do

 devise_for :users

 resources :wikis do
   resources :collaborators
 end

 resources :charges, only: [:new, :create] do
   get 'status_changing', on: :collection
 end


 mount StripeEvent::Engine, at: 'http://www.example.com/'

 root to: 'wikis#index'

end
