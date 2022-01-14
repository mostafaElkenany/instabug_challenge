class Chat < ApplicationRecord
    belongs_to :application, counter_cache: true
    before_validation( :on => :create ) do 
        self.number = self.application.chats.collect { | chat | chat.number }.max
        unless self.number.nil? 
            self.number += 1
        else
            self.number = 1
        end
      end
end
