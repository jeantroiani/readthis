class Category < ActiveRecord::Base
	has_many :posts

	def self.sort_by_posts_in(category)	
		sort{|b,a| Post.where(category_id: a.id).size <=> Post.where(category_id: b.id).size}
	end

end
