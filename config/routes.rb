Rails.application.routes.draw do
  get 'phrase/index'

  match 'phrase/' => 'phrase#create', :via => :post
  match 'phrase/' => 'phrase#destroy', :via => :delete
  match 'phrase/' => 'phrase#update', :via => :update

  match 'category/' => 'category#create', :via => :post
  match 'category/' => 'category#destroy', :via => :delete
  match 'category/' => 'category#update', :via => :update

  match 'speech/' => 'speech#create', :via => :post
  match 'setting/voice/' => 'setting#get_voices', :via => :get
  match 'setting/voice/' => 'setting#update_voice', :via => :post
  match 'setting/current_category/' => 'setting#get_current_category', :via => :get
  match 'setting/current_category/' => 'setting#update_current_category', :via => :post
  match 'setting/fixed_category/' => 'setting#update_fixed_category', :via => :post

  root 'main#index'
end

