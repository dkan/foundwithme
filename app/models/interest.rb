class Interest < ActiveRecord::Base
  attr_accessible :name

  def self.get_ids_from_omniauth(omniauth)
    
    ids = []
    interest_list = omniauth.extra.raw_info.interests
    
    if interest_list
      interest_list = interest_list.split(',') 
      interest_list.each do |interest|
        ids << self.find_or_create_by_name(interest.strip.downcase).id
      end
    end    
    ids
  end
end
