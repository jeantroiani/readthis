require 'rails_helper'
  
  context 'categories' do
    
    describe 'can' do

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

        @post = user.posts.create(title: 'Hello World',
                                  url: 'http://www.test.com',
                                  category_id: category.id)

        category_2 = Category.create(tags: 'Science')

        @post_2 = user_2.posts.create(title: 'Hello Moon',
                                      url: 'http://www.test_2.com',
                                      category_id: category_2.id)

      end

      it 'show all available' do
 
        visit('/posts')
        click_link('Categories')
        expect(page).to have_link('History')
        expect(page).to have_link('Science')
      end

      it 'filter post by selection from categories' do
 
        visit('/categories')
        click_link('History', match: :first)
        expect(page).to have_link('Hello World')
        expect(page).not_to have_content('Hello Moon')
      end

      it 'filter post by selection from index' do
 
        visit('/posts')
        click_link('History', match: :first)
        expect(page).to have_link('Hello World')
        expect(page).not_to have_content('Hello Moon')
      end

      it 'inform if no post is created under it' do
        Category.create(tags: 'Earthquake')
        visit('/posts')
        click_link('Earthquake', match: :first)
        expect(page).to have_content('No posts in this category yet.')
      end

    end

  end
