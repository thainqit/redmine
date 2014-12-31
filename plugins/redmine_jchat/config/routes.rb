# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
post 'chats/create' => 'chat#create'
get 'chats/index' => 'chat#index'
post 'chats/index' => 'chat#index'
get 'chats/show_user' => 'chat#show_user'
post 'chats/show_user' => 'chat#show_user'