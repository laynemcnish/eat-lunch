Rails.application.routes.draw do
   root 'dashboard#index'

   resource :dashboard, controller: :dashboard
end
