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

		it 'sorts posts by more votes all the time' do
			login_as user
			visit('/posts')
			click_link('like',match: :first)
			click_link('Hot')
			expect(page).to have_content('Hello Sun')
			expect(page).not_to have_content('Hello World')
		end

		it 'sorts posts by more controversial' do
			login_as user
			visit('/posts')
			click_link('like',match: :first)
			logout user
			login_as user_2
			click_link('Dislike',match: :first)
			click_link('Controversial')
			expect(page).to have_content('Hello Sun')
			expect(page).not_to have_content('Hello World')
		end

	end
