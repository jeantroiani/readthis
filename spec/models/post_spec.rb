require 'rails_helper'

RSpec.describe Post, :type => :model do

	describe 'post' do
		
		it 'can be sorted by likes, hottest will go on top' do

			@post_1 = Post.create(title: 'Hello World', created_at: '2014-09-03 20:41:30.488817')
			@post_2 = Post.create(title: 'Hello Moon', 	created_at: '2014-09-03 20:41:30.488817')
			@post_3 = Post.create(title: 'Hello Marth',	created_at: '2014-09-01 20:41:30.488817')
			Like.create(post_id: @post_1.id)
			2.times{ Like.create(post_id: @post_2.id)}
      expect(Post.sort_by_hotness).to eq([@post_2,@post_1,@post_3])
		end

		it 'with less likes will go at bottom' do

			@post_1 = Post.create(title: 'Hello World', created_at: '2014-09-03 20:41:30.488817')
			@post_2 = Post.create(title: 'Hello Moon', 	created_at: '2014-09-03 20:41:30.488817')
			@post_3 = Post.create(title: 'Hello Marth',	created_at: '2014-09-01 20:41:30.488817')
			Like.create(post_id: @post_2.id)
			4.times{ Like.create(post_id: @post_3.id)}
      expect(Post.sort_by_hotness).to eq([@post_3,@post_2,@post_1])
		end
		
		it 'can be sorted by recently created' do
	
			@post_1 = Post.create(title: 'Hello World', created_at: '2014-09-03 20:41:30.488817')
			@post_2 = Post.create(title: 'Hello Moon')
			expect(Post.sort_by_newer).to eq([@post_2])
		end

		it 'will not show posts older than 24hr in the newer page'  do
	
			@post_1 = Post.create(title: 'Hello World', created_at: '2014-09-03 20:41:30.488817')
			@post_2 = Post.create(title: 'Hello Moon' , created_at: '2012-10-03 20:41:30.488817')
			expect(Post.sort_by_newer).to eq([])
		end

		it 'will show only posts that the difference of likes/dislikes is less than 100%'  do
	
			@post_1 = Post.create(title: 'Hello World', created_at: '2014-09-03 20:41:30.488817')
			@post_2 = Post.create(title: 'Hello Moon', 	created_at: '2014-09-03 20:41:30.488817')
			Like.create(post_id: @post_1.id)
			Like.create(post_id: @post_2.id)
			4.times{ Dislike.create(post_id: @post_1.id)}
			Dislike.create(post_id: @post_2.id)
      expect(Post.sort_by_controversial).to eq([@post_2])
		end

	end

end
