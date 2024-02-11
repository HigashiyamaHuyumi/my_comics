Rails.application.routes.draw do
  
  # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  scope module: 'user' do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
		get '/users/my_page', to: 'users#my_page', as: 'my_page'
		get '/users/my_page/infomation', to: 'users#infomation', as: 'infomation'
    resources :users, only: [:show, :update] do
		  get :confirm, on: :member # 退会確認
      patch :withdrawal, on: :member # 退会処理
		end
		resources :comics, only: [:new, :show, :edit, :create, :update, :destroy] do
		  get 'tag', on: :member
    end
		resources :bookshelves
		resources :tags, only: [:index, :create, :destroy] do
	    get 'comic', on: :member
    end
    resources :volumes, only: [:index, :destroy]
		get 'books/search', to: "books#search", as: 'search'
    resources :books do
      post 'bookshelf', on: :member
    end
	end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
	  resources :users,only: [:index, :show, :edit, :update]
	end
  
  root to: "homes#top"
  get '/about', to: 'homes#about', as: 'home_about'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

end