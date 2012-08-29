Songplan::Application.routes.draw do
  root :to => "pages#index"

  resources :songs
end
