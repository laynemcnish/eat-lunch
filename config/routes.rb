Rails.application.routes.draw do
   root 'dashboard#index'

   resource :dashboard, controller: :dashboard do
     post 'submit' => 'dashboard#submit'
   end
   resource :restaurants do
     get 'get_list' => 'restaurants#get_list'
     post 'get_restaurant' => 'restaurants#get_restaurant'
   end
   resource :menus, only: [:create]
end
