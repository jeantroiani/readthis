class Post < ActiveRecord::Base
	
	belongs_to :user
	has_many 	 :likes
	has_many 	 :dislikes
	has_many 	 :comments
	belongs_to :category

	def rating
		self.likes.count - self.dislikes.count
	end

	def self.sort_by_hotness
		sort_by_newer.sort{|a,b| b.likes.count <=> a.likes.count }
	end

	def	self.sort_by_newer
		where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).reverse
	end
	
	def	self.sort_by_controversial
		select{|post|(((post.likes.count.to_f - post.dislikes.count).abs / ((post.likes.count + post.dislikes.count)/2))*100) <= 10.0 }
	end
	
end
