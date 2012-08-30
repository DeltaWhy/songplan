Songplan::Application.routes.draw do
  root :to => "pages#index"

  resources :songs do
    member do
      get ':key', :action => 'show', :constraints => {:key => /([A-Ga-g][+-]?)|lyrics/}, :as => 'transpose'
    end
  end
end
