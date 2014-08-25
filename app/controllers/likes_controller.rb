class LikesController < ApplicationController

	def create
		@like=Like.create(params.permit(:post_id))
		redirect_to('/posts')
	end
	
end
