class LikesController < ApplicationController

	def create
		post = Post.find(params['post_id'])
		if post.dislikes.find_by(user_id: current_user.id).nil?
			Like.create(post_id: params[:post_id], user_id: current_user.id)
			redirect_to('/posts')
		else	
			post.dislikes.find_by(user_id: current_user.id).destroy
			redirect_to('/posts')
		end
	end

end

#More likes overall

def top
	@posts = Post.all
	@posts.sort do |a,b|
		a.likes <=> b.likes
	end
end


def hot
	posts = Post.all
	posts.sort()
	post.likes
end
#More likes in the first week

def controversial
	posts = Post.all
	post.each
	post.likes
end
#Equal amount of likes or dislikes

def new
	posts = Post.all
	post.each
	post.likes
end
#Created in the day
