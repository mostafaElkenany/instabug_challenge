class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages

  before_validation(on: :create) do
    self.number = application.chats.collect { |chat| chat.number }.max
    if number.nil?
      self.number = 1
    else
      self.number += 1
    end
  end
end
