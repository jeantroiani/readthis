class CommentsController < ApplicationController
	
	def index	
		@post= Post.find(params[:post_id])
		@comment= Comment.new
	end

	def create
		@post= Post.find(params[:post_id])
		@post.comments.create(reply: params[:comment][:reply])
		redirect_to :back
	end

end
