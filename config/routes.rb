Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
     resources :users, only: [ :index, :show, :create, :destroy, :update ]
     post "/users/admin", to: "users#createByAdmin"
     resources :tokens, only: [ :create ]

     resources :singers, only: [ :index, :show, :create, :update, :destroy ]
     get "/singers/:id/musics", to: "singers#singermusics"
     post "/singers/import", to: "singers#import"
     post "/singers/export", to: "singers#export"
     get "/singer/list", to: "singers#list"

     resources :musics, only: [ :index, :show, :create, :update, :destroy ]

     resources :reports, only: [ :index ]
    end
  end
end
