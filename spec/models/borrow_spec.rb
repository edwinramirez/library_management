# spec/models/borrow_spec.rb

require 'rails_helper'

RSpec.describe Borrow, type: :model do
  describe 'validations' do
    before do
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Sample Book', author: 'Author Name', total_copies: 5)
    end

    it 'is valid with valid attributes' do
      borrow = Borrow.new(user: @user, book: @book, due_date: Date.today + 7)
      expect(borrow).to be_valid
    end

    it 'is not valid if the book is not available' do
      allow_any_instance_of(Borrow).to receive(:book_is_available).and_return(false)
      borrow = Borrow.new(user: @user, book: @book, due_date: Date.today + 7)
      expect(borrow).not_to be_valid
    end

    it 'is not valid if the user has already borrowed the book' do
      Borrow.create(user: @user, book: @book, due_date: Date.today + 7)
      borrow = Borrow.new(user: @user, book: @book, due_date: Date.today + 7)
      expect(borrow).not_to be_valid
    end
  end

  describe 'class methods' do
    before do
      @user = User.create(email: 'test@example.com', password: 'password')
      @book1 = Book.create(title: 'Book 1', author: 'Author 1', total_copies: 5)
      @book2 = Book.create(title: 'Book 2', author: 'Author 2', total_copies: 3)
      @borrow1 = Borrow.create(user: @user, book: @book1, due_date: Date.today, return_date: nil)
      @borrow2 = Borrow.create(user: @user, book: @book2, due_date: Date.today + 1, return_date: nil)
    end

    describe '.total_borrowed_books' do
      it 'returns the total number of borrowed books' do
        expect(Borrow.total_borrowed_books).to eq(2)
      end
    end

    describe '.due_today' do
      it 'returns borrows that are due today' do
        result = Borrow.due_today
        expect(result).to include(@borrow1)
        expect(result).not_to include(@borrow2)
      end
    end

    describe '.borrowed_books_by_due_date' do
      it 'returns borrowed books ordered by due date' do
        result = Borrow.borrowed_books_by_due_date
        expect(result).to eq([@borrow2, @borrow1])
      end
    end
  end
end