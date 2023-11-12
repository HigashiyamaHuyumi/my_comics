Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  scope module: 'user' do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
		get '/users/my_page', to: 'users#my_page', as: 'my_page' #マイページ用のルート
		get '/users/my_page/infomation', to: 'users#infomation', as: 'infomation'
    resources :users, only: [:update] do # 顧客リソース用のルートを追加
		  get :confirm, on: :member # 退会確認ページ用のルート
      patch :withdrawal, on: :member # 退会処理用のルート
		end
		resources :comics
	end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get '/about', to: 'homes#about', as: 'home_about'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  get 'books/search', to: "books#search"
end
