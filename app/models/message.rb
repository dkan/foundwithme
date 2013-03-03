class Message < ActiveRecord::Base
  attr_accessible :body, :recipient_id, :sender_id
end
