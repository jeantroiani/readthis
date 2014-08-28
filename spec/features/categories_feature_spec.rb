require 'rails_helper'
	
	context 'categories' do
		
		describe 'allows' do

			before(:each) do
				category= Category.create(tags: 'History')
				@post = user.posts.create(title: 'Hello World', url: 'http://www.test.com', category: category)

				category_2= Category.create(tags: 'History')
				@post_2 = user_2.posts.create(title: 'Hello Moon', url: 'http://www.test_2.com', category: category_2)

			end

			it 'filter by selection' do
				visit(/post)
				click_link('History')
				expect(page).to have_content('Hello World')
				expect(page).not_to  have_content('Hello Moon')
			end

		end

	end
