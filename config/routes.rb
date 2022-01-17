Rails.application.routes.draw do
  resources :applications, except: %w[show update destroy]
  get    'applications/:token' => 'applications#show'
  patch  'applications/:token' => 'applications#update'

  get    'applications/:token/chats' => 'chats#index'
  post   'applications/:token/chats' => 'chats#create'

  get    'applications/:token/chats/:chat_number/messages' => 'messages#index'
  post   'applications/:token/chats/:chat_number/messages' => 'messages#create'
  patch  'applications/:token/chats/:chat_number/messages/:message_number' => 'messages#update'

  get    'messages' => 'messages#search'
end
