Rails.application.routes.draw do
  get 'phrase/index'

  match 'phrase/' => 'phrase#create', :via => :post
  match 'phrase/' => 'phrase#destroy', :via => :delete
  match 'phrase/' => 'phrase#update', :via => :update

  match 'category/' => 'category#create', :via => :post
  match 'category/' => 'category#destroy', :via => :delete

  match 'speech/' => 'speech#create', :via => :post

  root 'main#index'
end

