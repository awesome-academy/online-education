Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "pages#index"
    get "/signup", to: "users#new"
    get "/recruitment", to: "trainer_candidates#index"
    post "/signup", to: "users#create"
    get "/login", to: "jwt#new"
    post "/login", to: "jwt#create"
    delete "/logout", to: "users#destroy"
    post "/test_results", to: "test_results#create"

    resources :shops, only: %i(index show)
    resources :carts, only: %i(index destroy)
    resources :trainer_candidates, only: %i(index)
    resources :users, only: %i(new create show destroy)
    resources :purchased_courses, only: %i(index create show destroy)

    resources :courses, only: %i(show) do
      resources :lessons, only: %i(index new create)
      resources :trainer_candidates, only: %i(new create)
      resources :carts, only: %i(create)
    end
    resources :lessons, only: %i(show) do
      resources :questions, only: %i(new create destroy)
    end
    
    namespace :admin do
      resources :courses, except: %i(edit)
    end
  end
end
