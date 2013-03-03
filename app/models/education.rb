class Education < ActiveRecord::Base
  attr_accessible :degree, :end_date, :institution, :start_date
  
  belongs_to :user
end
