Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "pages#index"
    get "/home", to: "pages#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    resources :users, only: %i(new create show)
  end
end
