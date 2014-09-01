class CategoriesController < ApplicationController
	def index
		@categories = Category.all
	end

	def show
		@posts = Post.where(category_id: params['id'])
	end
end

def category_of(post)
	Category.find_by(id: post.category_id).tags
end

def Post_in(category)
	Post.find_by(category_id: category.id)	
end