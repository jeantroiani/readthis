require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do

	describe 'categories' do
		before(:each) do
			@category_1 = Category.create(tags: 'hello')
			@category_2 = Category.create(tags: 'goodbye')
			post_1 		  = Post.create(title: 'Hello World', category_id: @category_1.id )
			post_2 		  = Post.create(title: 'Hello Moon' , category_id: @category_2.id )
			post_3 		  = Post.create(title: 'Hello Marth', category_id: @category_2.id )			
		end
	
		it 'can be ordered number of posts contained' do
			categories = [@category_1, @category_2]
			expect(sort_by_posts_in(categories)).to eq([categories.last,categories.first])
		end	

	end 
end
