class PostsController < ApplicationController

before_action :authenticate_user!, except: [:index]

	def index
		@posts=Post.all
	end

	def new
		@post=Post.new
	end

	def create
		@post=current_user.posts.create(params.require(:post).permit(:title,:url))
		redirect_to ('/posts')
	end

	def edit
		@post=Post.find(params.require(:id))
	end

	def update
		post= Post.find_by(id: params['id'])
		if current_user == post.user
			@post=Post.find(params.require(:id))
			@post.update(params.require(:post).permit(:title,:url))
			
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
