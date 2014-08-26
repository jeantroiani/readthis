class Post < ActiveRecord::Base
	belongs_to :user
	has_many 	 :likes
	has_many 	 :dislikes

	def rating
		self.likes.count - self.dislikes.count
	end

end
