class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application, number)
    # Do something later
    chat = application.chats.new
    chat.number = number
    chat.save
  end
end
