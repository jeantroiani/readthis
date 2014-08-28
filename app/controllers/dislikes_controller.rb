class DislikesController < ApplicationController

	def create
		post = Post.find(params['post_id'])
		if post.likes.find_by(user_id: current_user.id).nil? 
			Dislike.create(post_id: params[:post_id], user_id: current_user.id)
			redirect_to ('/posts')
		else
			post.likes.find_by(user_id: current_user.id).destroy
			redirect_to('/posts')
		end
	end


end
