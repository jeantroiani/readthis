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


		let(:user) do 
			User.create( email: 'test@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		let(:user_2) do 
			User.create( email: 'test2@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		it 'Can be edited' do
			login_as user
			visit('/posts')
			click_link('New post')
			fill_in'Title', with: 'Hello World'
			click_button('Submit')
			click_link('Edit')
			expect(page).to have_field('Title', with: 'Hello World')
			fill_in'Title', with: 'Great day'
			click_button('Submit')
			expect(current_path) == posts_path
			expect(page).to have_content('Great day')
		end 

		it 'Cannot be edited if you have not signed in' do
			Post.create( title: 'Hello World')
			login_as user
			visit('/posts')
			logout user
			expect(page).not_to have_link('Edit')
			expect(current_path) == new_user_session_path 
		end 

		it 'Cannot be edited if you are not the author of the post' do
			visit('/posts')
			login_as user
			click_link('New post')
			fill_in'Title', with: 'Hello World'
			click_button('Submit')
			logout user
			login_as user_2
			click_link('Edit')
			expect(page).to have_content('Hello World')
			expect(current_path) == new_user_session_path 
		end 
	
	end

	context 'Deleting post' do


		let(:user) do 
			User.create( email: 'test@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		let(:user_2) do 
			User.create( email: 'test2@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		it'users can delete a post' do
			login_as user
			visit('/posts')	
			click_link('New post')
			fill_in 'Title', with: 'Hello World'
			click_button('Submit')
			click_link('Delete')
			expect(page).not_to have_content('Hello World')
			# expect(current_path) == posts_path
		end

		it'users can delete only their post' do
			login_as user
			visit('/posts')
			click_link('New post')
			fill_in 'Title', with: 'Hello World'
			click_button('Submit')
			expect(page).to have_content('Hello World')
			logout user
			login_as user_2
			click_link('Delete')
			expect(page).to have_content('You can delete only post written by you')
		end

	end

end
