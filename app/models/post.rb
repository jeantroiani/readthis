class Post < ActiveRecord::Base
	belongs_to :user
	has_many 	 :likes
	has_many 	 :dislikes

	def rating
		self.likes.count - self.dislikes.count
	end

	# def rated
	# 	self.find.likes.user_id 
	# 	self.
	# end

end
