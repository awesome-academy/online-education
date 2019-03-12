Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "pages#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    resources :users, only: %i(new create show)
    resources :courses, only: %i(index show) do
      resources :lessons, only: %i(new create index show)
    end
  end
end
