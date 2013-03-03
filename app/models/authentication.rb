class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :uid, :last_synced
end
