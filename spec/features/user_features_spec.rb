require 'rails_helper'

describe 'Users' do

	context 'New' do
		it 'users can sign up' do
			visit('/posts')
			click_link('Sign up')
			fill_in 'Email', 								 with: 'test@test.com'
			fill_in 'Password', 						 with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			click_button('Sign up')
			expect(page).to have_content('Welcome! You have signed up successfully.')
		end 
	
	end

	context 'already signed up' do

		let (:user) do 
			User.create(email: 'test@test.com',
							 		password: '12345678',
							 		password_confirmation: '12345678')
		end

		it 'can sign in' do
			user
			visit('/posts')
			click_link('Sign in')
			fill_in 'Email', 								 with: 'test@test.com'
			fill_in 'Password', 						 with: '12345678'
			click_button('Log in')
			expect(page).to have_content('Signed in successfully.')
		end 

		it 'can sign out' do
			login_as user			
			visit('/posts')			
			click_link('Sign out')
			expect(page).to have_content('Signed out successfully.')
		end 

	end

end

