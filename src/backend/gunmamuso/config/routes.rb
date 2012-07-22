Gunmamuso::Application.routes.draw do
  root :to => 'welcome#index'
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout
  namespace :api do
    match 'user/:id', :to => "api#user", :defaults => { :format => 'json' }
    match 'register/:id', :to => "api#registerUser", :defaults => { :format => 'json' }
    match 'genki/generate/:fb_id', :to => "api#generateGenki", :defaults => { :format => 'json' }
  end 
end
