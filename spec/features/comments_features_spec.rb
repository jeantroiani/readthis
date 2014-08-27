require 'rails_helper'

	describe 'Comments' do

		context 'can be' do

			let(:user) do
				User.create(email: 'test@test.com',
										password: '12345678',
										password_confirmation:'12345678')
			end

			before(:each) do
				user.posts.create(title: 'Hello World', url: 'http://www.google.com')
			end

			it ' seen when clicking on Comments in the main page' do	
				Comment.create(reply: 'Hiya', post_id: 1)
				login_as user
				visit('/posts')
				click_link('Comment') 
				expect(page).to have_content('Hello World')
				expect(page).to have_content('Hiya')
			end

			it ' seen only if they belong to a selected post' do	
				Comment.create(reply: 'How are you?', post_id: 1)
				Comment.create(reply: 'How is life?', post_id: 2)
				login_as user
				visit('/posts')
				click_link('Comment') 
				expect(page).to have_content('Hello World')
				expect(page).to have_content('How are you?')
				expect(page).not_to have_content('How is life?')
			end

			xit ' wrote after a post by a signed in user' do
				login_as user
				visit('/posts')
				click_link('Comment')
				expect(current_path) == post_comments_path
				expect(page).to have_textarea_field
				fill_in 'Textarea', with: 'Hiya'
				click_link('Post')
				expect(page).to have_content('Hello World')
				expect(page).to have_content('Hiya')
			end
		
		end
		
	end 