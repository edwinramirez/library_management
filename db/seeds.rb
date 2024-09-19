require 'faker'

# Create books
50.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    isbn: Faker::Code.isbn,
    total_copies: Faker::Number.between(from: 5, to: 10)
  )
end

# Create an admin user
User.create(email: 'boss@library.com', password: 'password', admin: true)

# Create regular users
10.times do
  User.create(email: Faker::Internet.email, password: 'password', admin: false)
end

# Create overdue borrows
overdue_users = User.where(admin: false).sample(3)
overdue_users.each do |user|
  user.borrows.create(
    borrow_date: Date.today - 3.weeks,
    due_date: Date.today - 1.week,
    return_date: nil,
    book: Book.all.sample
  )
end

# Create borrows that are due today
today_users = User.where(admin: false).sample(4)
today_users.each do |user|
  user.borrows.create(
    borrow_date: Date.today - 2.weeks,
    due_date: Date.today,
    return_date: nil,
    book: Book.all.sample
  )
end