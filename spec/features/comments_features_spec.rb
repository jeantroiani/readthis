require 'rails_helper'

	describe 'Comments' do

		context 'can be' do

			let(:user) do
				User.create(email: 'test@test.com',
										password: '12345678',
										password_confirmation:'12345678')
			end

			let(:user_2) do
				User.create(email: 'test_2@test.com',
										password: '12345678',
										password_confirmation:'12345678')
			end

			before(:each) do
			
				category= Category.create(tags: 'History')
				@post = user.posts.create(title: 'Hello World', url: 'http://www.test.com', category: category)
		
				category_2= Category.create(tags: 'History')
				@post_2 = user_2.posts.create(title: 'Hello Moon', url: 'http://www.test_2.com', category: category_2)
			
			end

			it 'seen when clicking on Comments in the main page' do	
				@post.comments.create(reply: 'Hiya')
				login_as user
				visit('/posts')
				click_link('Comment', match: :first) 
				expect(page).to have_content('Hello World')
				expect(page).to have_content('Hiya')
			end

			it 'seen only if they belong to a selected post' do	
				@post.comments.create(reply: 'How are you?')
				@post_2.comments.create(reply: 'How is life?')
				login_as user
				visit('/posts')
				click_link('Comment',match: :first) 
				expect(page).to have_content('Hello World')
				expect(page).to have_content('How are you?')
				expect(page).not_to have_content('How is life?')
			end

			it 'written after a post by a signed in user' do
				login_as user
				visit('/posts')
				click_link('Comment', match: :first)
				fill_in 'Reply', with: 'Hiya'
				click_button('Post')
				expect(page).to have_content('Hello World')
				expect(page).to have_content('Hiya')
			end

			it 'not written if you are no signed' do
				@post.comments.create(reply: 'Hello')
				visit('/posts')
				click_link('Comment', match: :first)
				expect(page).to have_content('Please sign to leave a comment')
			end

			it 'closed and go back to see all posts' do
				visit('/posts')
				click_link('Comment', match: :first)
				click_link('Back')
				expect(current_path) == posts_path
			end 

			it 'counted in the index' do
				@post.comments.create(reply: 'Hello')
				visit('/posts')
				expect(page).to have_content('1 Comments')
			end 
		end
				
	end 