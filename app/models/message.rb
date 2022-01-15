class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true

  #   before_validation(on: :create) do
  #     self.number = chat.messages.collect { |message| message.number.to_i }.max
  #     if number.nil?
  #       self.number = 1
  #     else
  #       self.number += 1
  #     end
  #   end
end
