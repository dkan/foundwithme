class UserInterest < ActiveRecord::Base
  attr_accessible :interest_id, :user_id

  belongs_to :interest
  belongs_to :user
end
