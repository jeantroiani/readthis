class Post < ActiveRecord::Base
	belongs_to :user
	has_one :text
	
end
