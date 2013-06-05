HrTracker::Application.routes.draw do

  resources :contracts do
    resources :salary_activities do
      get 'discussions' => 'discussions#new_or_edit'
      match 'discussions' => 'discussions#create_or_update', via: [:post, :put]
    end
  end

  namespace 'home' do
    get "dashboard"
    get "index"
  end

  root :to => 'home#index'

  devise_for :employee
  resources :employees do
    collection do
      get 'ajax_list_all'
    end
  end

  scope ":nickname" do
    resources :bonuses, controller: :bonuses
  end

end
