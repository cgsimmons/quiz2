Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'home#index', as: :home

  resources :requests

  patch '/requests/:id/done' => 'requests#update_done', as: :update_done
  get '/departments' => 'requests#dstats', as: :dstats

end
