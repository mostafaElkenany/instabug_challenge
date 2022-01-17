require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new log: true