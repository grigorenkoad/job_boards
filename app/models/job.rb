class Job < ActiveRecord::Base
  
  scope :title, -> (title) { where title: title }
  scope :location, -> (location) { where location: location }
  scope :company, -> (company) { where company: company }
  scope :category, -> (category) { where category: category }

end
