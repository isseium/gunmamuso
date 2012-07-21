Gunmamuso::Application.routes.draw do
  namespace :api do
    match 'test/:id', :to => "api#test", :defaults => { :format => 'json' }
    match 'register/:id', :to => "api#registerUser", :defaults => { :format => 'json' }
  end 
end
