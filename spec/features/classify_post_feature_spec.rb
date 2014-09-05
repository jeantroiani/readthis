require 'rails_helper'

	context 'classify of post' do

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

		let(:user_3) do 
			User.create(email: 'test_3@test.com',
									password: '12345678',
									password_confirmation: '12345678')
		end

		before(:each) do
			category = Category.create(tags: 'History')

      post = user.posts.create(title: 'Hello World',
                                url: 'http://www.test.com',
                                created_at: '2014-09-03 20:00:00.0',
                                category_id: category.id)

      category_2 = Category.create(tags: 'Science')

      post_2 = user.posts.create(title: 'Hello Moon',
                                    url: 'http://www.test_2.com',
                                    created_at: '2014-09-01 20:00:00.0',
                                    category_id: category_2.id)
		end

		xit 'sorts them by amount of likes' do

			login_as user
			visit('/posts')
			click_link('Like',match: :first)
			click_link('Hot')
			expect(page).to have_content('Hello Moon')
			expect(page).to have_content('Hello World')
		end

		it 'sorts them by more controversial' do

			login_as user
			visit('/posts')
			click_link('Like', match: :first)
			logout user
			login_as user_2
			click_link('Dislike',match: :first)
			click_link('Controversial')
			expect(current_path).to eq('/posts.sort_by_controversial')
			expect(page).to have_content('Hello World')
			expect(page).not_to have_content('Hello Moon')
		end

		it 'showing only created in the last 24 hours' do

			category_3 = Category.create(tags: 'History')
		  
		  post_3 = user.posts.create(title: 'Hello Marth',
                                 url: 'http://www.test_2.com',             
                                 category_id: category_3.id)
			
			login_as user
			visit('/posts')
			click_link('Newer')
			expect(current_path).to eq('/posts.sort_by_newer')
			expect(page).to have_content('Hello Marth')
			expect(page).not_to have_content('Hello World')
		end

	end
