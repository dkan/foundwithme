class Employment < ActiveRecord::Base
  attr_accessible :company, :end_date, :start_date, :title
end
