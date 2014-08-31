class CategoriesController < ApplicationController
	def index
		@categories = Category.all
	end

	def show
		@posts = Post.where(category_id: params['id'])
	end
end
