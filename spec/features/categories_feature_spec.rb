require 'rails_helper'
  
  context 'categories' do
    
    describe 'allows' do

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
        category= Category.create(tags: 'History')

        @post = user.posts.create(title: 'Hello World',
                                  url: 'http://www.test.com',
                                  category: category)

        category_2= Category.create(tags: 'Science')

        @post_2 = user_2.posts.create(title: 'Hello Moon',
                                      url: 'http://www.test_2.com',
                                      category: category_2)

      end

      it 'to show all the categories available' do
  
        visit('/posts')
        click_link('Categories')
        expect(page).to have_link('History')
        expect(page).to have_link('Science')
      end

      it 'filter post by selection' do
        visit('/categories')
        click_link('History')
        expect(page).to have_content('Hello World')
        expect(page).not_to have_content('Hello Moon')
      end

    end

  end
