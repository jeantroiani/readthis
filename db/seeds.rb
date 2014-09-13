# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user_01 = User.create(email: 'test_01@test.com', password: '12345678', password_confirmation: '12345678')
@user_02 = User.create(email: 'test_02@test.com', password: '12345678', password_confirmation: '12345678')

category_01 = Category.create(tags: 'Computers')
category_02 = Category.create(tags: 'Science')
category_03 = Category.create(tags: 'Ruby on Rails')

post_1 = @user_01.posts.create(title: 'Hello World',    url: 'http://www.google.com', category_id: category_01.id)
post_2 = @user_02.posts.create(title: 'Rails is great', url: 'http://www.google.com', category_id: category_03.id)
