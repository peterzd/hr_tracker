HrTracker::Application.routes.draw do

  resources :contracts


  namespace 'home' do
    get "dashboard"
    get "index"
  end

  root :to => 'home#index'

  devise_for :employee
  resources :employees


end
