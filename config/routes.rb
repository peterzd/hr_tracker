HrTracker::Application.routes.draw do

  namespace 'home' do
    get "dashboard"
    get "index"
  end

  root :to => 'home#index'

  resources :employees
  devise_for :employees
end
