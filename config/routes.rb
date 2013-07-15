HrTracker::Application.routes.draw do

  resources :contracts do
    resources :salary_activities do
      get 'discussions' => 'discussions#new_or_edit'
      match 'discussions' => 'discussions#create_or_update', via: [:post, :put]

      #collection do
      #  get 'ajax_new'
      #end
    end

    collection do
      get 'ajax_new'
    end
  end

  namespace 'home' do
    get "dashboard"
    get "index"
    get "new_contract_modal"
  end

  root :to => 'home#index'

  devise_for :employee
  resources :employees do
    collection do
      get 'ajax_list_all'
      get 'ajax_list_current'
    end

		resources :notes
  end

  scope ":nickname" do
    resources :bonuses, controller: :bonuses do
      get 'emp_bonuses', on: :collection
    end

  end

  get '/:nickname/contracts', to: 'contracts#emp_contracts', nickname: /[a-z]+/, as: :emp_contracts
  get '/:nickname/salary_activity', to: 'salary_activities#ajax_new', nickname: /[a-z]+/, as: :ajax_new
end
