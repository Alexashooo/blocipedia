Rails.application.routes.draw do

 resources :wikis
 devise_for :users

 root to: 'wikis#index'

end
