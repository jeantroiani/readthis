class CategoriesController < ApplicationController
	def index
		@categories = Category.all
	end

	def show
		@posts = Post.where(category_id: params['id'])
	end
end

def Post_in(category)
	Post.find_by(category_id: category.id)	
end



