class PostsController < ApplicationController

before_action :authenticate_user!, except: [:index]

	def index
		if params[:format]
			@posts = Post.send(params[:format].to_sym)
		else
			@posts = Post.all
		end	
		@categories =Category.all
	end

	def new
		@post = Post.new
	end

	def create
		@category = Category.find_or_create_by(tags: params['post']['category'])
		@post = current_user.posts.create(params.require(:post).permit(:title,:url))
	
		@post.update(category_id: @category.id)
		redirect_to ('/posts')
	end

	def edit
		@post = Post.find(params.require(:id))
	end

	def update
		@post = Post.find_by(id: params['id'])
		if current_user == @post.user
			@post.update(params.require(:post).permit(:title,:url))
			category = Category.find_or_create_by(tags: params['post']['category'])
			@post.update(category_id: category.id)
			redirect_to ('/posts')
			flash.notice = "Post have been updated"
		else
			redirect_to('/posts')
			flash.alert = 'Posts can be only edited by its author'
		end
	end

	def destroy
		post = Post.find_by(id: params['id'])
		if current_user == post.user
			Post.destroy(params.require(:id))
			redirect_to ('/posts')
			flash.alert = "Post have been deleted"
		else
			redirect_to('/posts')
			flash.alert = "You can delete only post written by you" 	
		end	
	end


end

def sort_by_posts_in(category)	
	category.sort{|b,a| Post.where(category_id: a.id).size <=> Post.where(category_id: b.id).size}
end

def top_popular(category)
	sort_by_posts_in(category).first(15)
end

