class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.search(query, chat_id)
    __elasticsearch__.search({
                               query: {
                                 bool: {
                                   must: [
                                     { match: { "chat_id": chat_id } },
                                     { query_string: { query: "*#{query}*", fields: ['content'] } }
                                   ]
                                 }
                               }
                             })
  end

  #   before_validation(on: :create) do
  #     self.number = chat.messages.collect { |message| message.number.to_i }.max
  #     if number.nil?
  #       self.number = 1
  #     else
  #       self.number += 1
  #     end
  #   end
end
