class CommentsController < ApplicationController
	def index
		
		@post= Post.find(params[:post_id])
		@comments=Comment.all
	end
end
