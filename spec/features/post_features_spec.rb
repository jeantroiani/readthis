require 'rails_helper'

feature "PostFeatures", :type => :feature do
end

describe 'Posts' do
	
	context 'With posts' do
	
		before(:each) do
		Post.create( text: 'Hello World')
		end
	
		it 'can be seen when you visit the index' do
			visit('/posts')
			expect(current_path) == posts_path
			expect(page).to have_content('Hello World')
		end 
	end

	context 'No post' do

		it 'displays informative message' do
			visit('/posts')
			expect(current_path) == posts_path
			expect(page).not_to have_content('Hello World')
		end	
	end

	context 'Creating post' do

		it 'users can create posts' do

		end
	
	end 


end
