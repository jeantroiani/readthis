require 'rails_helper'

feature "PostFeatures", :type => :feature do
end

describe 'Posts' do
	
	context 'With posts' do
	
		before(:each) do
		Post.create( title: 'Hello World')
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
			expect(page).to have_content('No one has posted yet')
		end	
	end

	context 'Creating post' do
		
		let(:user) do 
			User.create( email: 'test@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		it 'users can write new posts' do
			visit('/posts')
			expect(current_path) == posts_path
			login_as user
			click_link('New post')
			fill_in 'Title', with: 'Hello World'
			click_button('Submit')
			expect(page).to have_content('Hello World')
		end

		it 'Can not write a post if user have not signed in' do
			visit('/posts')
			expect(current_path) == posts_path
			click_link('New post')
			expect(current_path) == new_post_path
			expect(page).to have_content('You need to sign in or sign up before continuing.')
		end
	
	end 

	context 'Editing post' do

		before(:each) do
		Post.create( title: 'Hello World')
		end

		let(:user) do 
			User.create( email: 'test@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		it 'Can be edited' do
			visit('/posts')
			login_as user
			click_link('Edit')
			expect(page).to have_field('Title', with: 'Hello World')
			fill_in'Title', with: 'Great day'
			click_button('Submit')
			expect(current_path) == posts_path
			expect(page).to have_content('Great day')
		end 

		it 'Cannot be edited if you have not signed in' do
			visit('/posts')
			login_as user
			logout user
			click_link('Edit')
			expect(current_path) == new_user_session_path 
		end 
	
	end

	context 'Deleting post' do

		it'users can delete a post' do
			
		end

	end

end
