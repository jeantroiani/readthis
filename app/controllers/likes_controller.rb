class LikesController < ApplicationController

	def create
		Like.create(params.permit(:post_id))
		redirect_to('/posts')
	end

end
