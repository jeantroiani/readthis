class PostsController < ApplicationController

before_action :authenticate_user!, except: [:index]

	def index
		@posts=Post.all
	end

	def new
		@post=Post.new
	end

	def create
		@post=Post.create(params.require(:post).permit(:title))
		redirect_to ('/posts')
	end

	def edit
		@post=Post.find(params.require(:id))
	end

	def update
		@post=Post.find(params.require(:id))
		@post.update(params.require(:post).permit(:title))
		redirect_to ('/posts')
	end

end
