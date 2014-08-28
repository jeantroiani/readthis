require 'rails_helper'

feature "PostFeatures", :type => :feature do
end

describe 'Posts' do
	
	context 'existing' do
		let(:user) do 
			User.create( email: 'test@test.com',
							 		 password:'12345678',
							 		 password_confirmation: '12345678')
		end

		before(:each) do
		category = Category.create(tags: 'science')
		user.posts.create( title: 'Hello World', url: 'www.test.com', category: category)
		end
	
		it 'can be seen when you visit the index' do
			visit('/posts')
			expect(current_path) == posts_path
			expect(page).to have_content('Hello World')
		end 
	end

	context 'when do not exist' do

		it 'displays informative message' do
			visit('/posts')
			expect(current_path) == posts_path
			expect(page).not_to have_content('Hello World')
			expect(page).to have_content('No one has posted yet')
		end	
	end

	context 'Creating them' do
		
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

		it 'can have an URL attached to the test' do
			expect(current_path) == posts_path
			login_as user
			visit('/posts')
			click_link('New post')
			fill_in 'Title', with: 'Hello World'
			fill_in 'Url' ,  with: 'http://www.google.co.uk'
			click_button('Submit')
			expect(page).to have_link('Hello World')
			click_link('Hello World')
			expect(current_path) == ('http://www.google.co.uk')
		end
	
	end 

	context 'Editing' do


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

		it 'Can be updated' do
			login_as user
			visit('/posts')
			click_link('New post')
			fill_in'Title', 	 with: 'Hello World'
			fill_in'Url', 		 with: 'www.test.com'
			fill_in'Category', with: 'Science'
			click_button('Submit')
			click_link('Edit')
			expect(page).to have_field('Title', with: 'Hello World')
			fill_in'Title', with: 'Great day'
			click_button('Submit')
			expect(current_path) == posts_path
			expect(page).to have_content('Great day')
		end 

		it 'Cannot be updated if you have not signed in' do
			category = Category.create(tags: 'science')
			user.posts.create(title: 'Hello World', url: 'test@test.com', category: category)
			login_as user_2
			visit('/posts')
			logout user_2
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

	context 'Deleting' do


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

		it 'can be done by user' do
			login_as user
			visit('/posts')	
			click_link('New post')
			fill_in 'Title', with: 'Hello World'
			click_button('Submit')
			click_link('Delete')
			expect(page).not_to have_content('Hello World')
			expect(current_path) == posts_path
		end

		it 'can be done by authors' do
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

	context 'Hold extra information' do
		let(:user) do 
		User.create( email: 'test@test.com',
						 		 password:'12345678',
						 		 password_confirmation: '12345678')
		end

		it'shows the date and author of the post' do
			login_as user
			visit('/posts')
			click_link('New post')
			fill_in 'Title', with: 'Hello World'
			click_button('Submit')
			expect(page).to have_content('Hello World')
			expect(page).to have_content("by test@test.com")
		end

	context'have a tag'do

		let(:user) do
				User.create(email: 'test@test.com',
										password: '12345678',
										password_confirmation:'12345678')
			end

			it'that can be written when creating it' do
				login_as user
				visit('/posts')
				click_link('New post')
				fill_in 'Title'			, with: 'Hello World'
				fill_in	'Url'	 			,	with: 'http://www.test.com'
				fill_in 'Category'	, with: 'Science'
				click_button('Submit')
				expect(current_path) == posts_path
				expect(page).to have_content('Science') 
			end
		end
	end
end