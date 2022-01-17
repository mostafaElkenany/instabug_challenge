class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :content
    end
  end

  def as_indexed_json(_options = nil)
    as_json(only: %i[content])
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          query_string: {
            query: "*#{query}*",
            fields: ['content']
          }
        }
      }
    )
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
