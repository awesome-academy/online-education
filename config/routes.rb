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

    resources :users, only: %i(new create show destroy)
    resources :purchased_courses, only: %i(index show destroy)
    resources :courses, only: %i(show) do
      resources :lessons, only: %i(index new create)
      resources :trainer_candidates, only: %i(new create)
    end
    resources :lessons, only: %i(show) do
      resources :questions, only: %i(new create destroy)
    end
    resources :shops, only: %i(index show) do
      resources :carts, only: %i(index create destroy)
    end
    resources :trainer_candidates, only: %i(index)

    namespace :admin do
      resources :courses, only: %i(index new create)
    end
  end
end
