# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

user1 = User.create(
  email: 'kennced@kennced.com',
  password: 'kennced'
)

user2 = User.create(
  email: 'rusk@rusk.com',
  password: 'ruskrusk'
)

category1 = Category.create(
  title: 'Category one',
  details: 'Category one details',
  target_date: Date.current,
  user_id: user1.id
)

category2 = Category.create(
  title: 'Category two',
  details: 'Category two details',
  target_date: Date.current,
  user_id: user1.id
)

category3 = Category.create(
  title: 'Category three',
  details: 'Category three details',
  target_date: Date.current.yesterday,
  user_id: user1.id
)

category4 = Category.create(
  title: 'Category four',
  details: 'Category four details',
  target_date: Date.current,
  user_id: user2.id
)

Task.create(
  title: 'Task one',
  body: 'Task one body',
  status: false,
  user_id: user1.id,
  category_id: category1.id
)

Task.create(
  title: 'Task two',
  body: 'Task two body',
  status: true,
  user_id: user1.id,
  category_id: category1.id
)

Task.create(
  title: 'Task three',
  body: 'Task three body',
  status: false,
  user_id: user1.id,
  category_id: category2.id
)

Task.create(
  title: 'Task four',
  body: 'Task four body',
  status: false,
  user_id: user1.id,
  category_id: category3.id
)

Task.create(
  title: 'Task five',
  body: 'Task five body',
  status: false,
  user_id: user2.id,
  category_id: category4.id
)