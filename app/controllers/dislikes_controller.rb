class DislikesController < ApplicationController
	def create
		Dislike.create(params.permit(:post_id))
		redirect_to ('/posts')
	end
end
