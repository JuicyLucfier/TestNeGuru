Rails.application.routes.draw do

  devise_for :users, path: :negurus, path_names: { sign_in: :login, sign_out: :logout }, controllers: { sessions: "users/sessions"}

  root 'tests#index'
  get 'my_badges', to: 'user_badge#index'

  resources :tests, only: :index do

    member do
      post :start
    end

  end

  resources :badges, only: :index

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :gists, only: :index
    resources :badges
  end

end
