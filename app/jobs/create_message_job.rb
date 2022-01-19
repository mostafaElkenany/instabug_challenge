class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat, content, number)
    # Do something later
    message = chat.messages.new(content)
    message.number = number
    message.save
  end
end
