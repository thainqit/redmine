# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
  match 'work_time/:action', :to => 'work_time#index'
  # match 'work_time/:action/:id', :to => 'work_time#show'
  match 'work_time/:action', :to => 'work_time#test'
  post  'work_time/create_user_issue', :to => 'work_time#create_user_issue'
  post 'work_time/check_day', :to => 'work_time#check_day'