Gunmamuso::Application.routes.draw do
  root :to => 'welcome#index'
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout
  namespace :api do
    match 'test/:id', :to => "api#test", :defaults => { :format => 'json' }
    match 'register/:id', :to => "api#registerUser", :defaults => { :format => 'json' }
  end 
end
