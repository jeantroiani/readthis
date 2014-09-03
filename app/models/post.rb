class Post < ActiveRecord::Base
	
	belongs_to :user
	has_many 	 :likes
	has_many 	 :dislikes
	has_many 	 :comments
	belongs_to :category

	def rating
		self.likes.count - self.dislikes.count
	end
	
	def	self.sort_by_hotness
			where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
	end
	

end
