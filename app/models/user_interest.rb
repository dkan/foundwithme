class UserInterest < ActiveRecord::Base
  attr_accessible :interest_id, :user_id

  belongs_to :interest
  belongs_to :user
  
  def self.update_user_interests (user_id, interest_ids, new_interest_list)
    ids = interest_ids || []
    
    if new_interest_list
      new_interest_list.each do |s|
        ids << Interest.find_or_create_by_name(s.downcase).id
      end
    end
    
    user = User.find(user_id)
    user.user_interests = []
    ids.each do |id| 
      user.user_interests.build(interest_id: id)
    end
    user.save!
  end
end
