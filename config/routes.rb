Rails.application.routes.draw do
 resources :xcusers
  get '/login' => 'xcusers#login'
  post '/login' => 'xcusers#login_commit'
end
