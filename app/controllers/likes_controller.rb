class LikesController < ApplicationController

	def create
		Like.create(post_id: params[:post_id], user_id: current_user.id)
		redirect_to('/posts')
	end
end
