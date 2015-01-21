Rails.application.routes.draw do
  resources :transactionns

  resources :purchases

  resources :transactions

  get 'gallery/create'
  get 'gallery/update'

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'visitors#index'

  get "contact" => "visitors#contact"
  get "blog" => "visitors#blog"
  get "order" => "visitors#order"
  get "checkout" => "visitors#checkout"

  get "admin" => "admin#index"
  get "articles" => "articles#index"


  post "visitors/receive" => "visitors#receive"
  post "transactionns/:id" => "transactionns#post"

  devise_for :users

  resources :users
  resources :designs
  resources :products
  resources :articles
  resources :contents
  resources :galleries
  resources :admin
  resources :charges
  resources :transactions
  resources :purchases
end
