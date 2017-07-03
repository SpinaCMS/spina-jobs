Spina::Engine.routes.draw do
  namespace :jobs, path: '' do
    resources :job_roles, path: :jobs, only: [:index, :show] do
      resources :job_applications, only: [:new, :create]

      member do
        get :apply, to: 'job_applications#new'
      end
    end
  end

  namespace :admin do
    namespace :jobs do
      resources :job_roles, path: :roles, except: :show
      resource :job_settings, path: :settings, only: [:edit, :update]
    end
  end
end
