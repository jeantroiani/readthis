require 'rails_helper'

RSpec.describe Post, :type => :model do

	describe 'post' do
		it 'can be sorted by hotness' do
			@post_1 = Post.create(title: 'Hello World', created_at: '2014-09-03 20:41:30.488817')
			@post_2 = Post.create(title: 'Hello Moon', 	created_at: '2014-09-03 20:41:30.488817')
			@post_3 = Post.create(title: 'Hello Marth',	created_at: '2014-09-01 20:41:30.488817')
			like_1 = Like.create(post_id: @post_1.id)
			like_2 = Like.create(post_id: @post_1.id)
			like_3 = Like.create(post_id: @post_2.id)
      expect(sort_by_hot).to eq([post_1,post_2])
		end


	end

end
