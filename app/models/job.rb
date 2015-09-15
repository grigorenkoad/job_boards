class Job < ActiveRecord::Base
  validates_uniqueness_of :req_num
end
