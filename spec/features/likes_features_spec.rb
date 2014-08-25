require 'rails_helper'
	
	describe 'Likes' do
		
		context 'Can rate a post' do
			
				let(:user) do
					User.create(email: 'test@test.com',
											password: '12345678',
											password_confirmation: '12345678')
				end

				let(:user_2) do
					User.create(email: 'test_2@test.com',
											password: '12345678',
											password_confirmation: '12345678')
				end

				before(:each)do
					user.posts.create(title: 'Hello World',url: 'www.google.com')
				end

			it 'by going up a number when you rate it positive' do

				login_as user
				visit ('/posts')
				expect(page).to have_content ('Hello World')
				expect(page).to have_content ('Likes: 0')
				click_link('Like')
				expect(page).to have_content ('Likes: 1')
			end

			it 'by going down a number when you rate it negative' do

				login_as user
				visit ('/posts')
				expect(page).to have_content ('Likes: 0')
				click_link('Like')
				expect(page).to have_content ('Likes: 1')
				click_link('Dislike')
				expect(page).to have_content ('Likes: 0')
			end

			it 'positive or negative only once per user' do

				login_as user
				visit ('/posts')
				expect(page).to have_content ('Likes: 0')
				click_link('Like')
				expect(page).to have_content ('Likes: 1')
				expect(page).not_to have_link('Like')
			end

			it 'positive and then remove it by clicking dislike and viceversa' do

				login_as user
				visit ('/posts')
				expect(page).to have_content ('Likes: 0')
				click_link('Like')
				expect(page).to have_content ('Likes: 1')
				click_link('Dislike')
				expect(page).to have_link ('Like')
			

			end

		end

	end