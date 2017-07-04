Spina::Engine.routes.draw do
  namespace :jobs, path: '' do
    resources :job_roles, path: :jobs, only: [:index, :show] do
      resources :job_applications, path: :applications, only: [:new, :create]
      get :apply, to: 'job_applications#new'
      get '/applications/thanks', to: 'job_applications#thanks', on: :collection
    end
  end

  namespace :admin do
    namespace :jobs do
      resources :job_roles, path: :roles, except: :show do
        resources :job_applications, path: :applications, only: [:index, :show, :destroy], shallow: true
      end
      resources :job_applications, path: :applications, only: :index
      resource :job_settings, path: :settings, only: [:edit, :update]
    end
  end
end
