Rails.application.routes.draw do
  resources :applications, :except => ['show', 'update', 'destroy']
  get    'applications/:token' => 'applications#show'
  patch  'applications/:token' => 'applications#update'
  get    'applications/:token/chats' => 'chats#show'
  post   'applications/:token/chats' => 'chats#create'
end
