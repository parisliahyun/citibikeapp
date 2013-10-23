Citi::Application.routes.draw do
  resources :users, only: [:new, :create, :show, :delete]

  resources :users do
    resources :favorites
      member do
        post 'favorite'
      end 
  end

  root 'welcome#index'
  get 'searches' => 'searches#index'
  get 'searches/results' => 'searches#results'
  resource :session, only: [:destroy, :create, :new]
end
