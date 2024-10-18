Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
     resources :users, only: [ :index, :show, :create, :destory ]
     resources :tokens, only: [ :create ]

     resources :singers, only: [ :index, :show, :create, :update, :destory ]
     get "/singers/:id/musics", to: "singers#singermusics"
     post "/singers/import", to: "singers#import"
     post "/singers/export", to: "singers#export"

     resources :musics, only: [ :index, :show, :create, :update, :destory ]
    end
  end
end
