# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many borrows' do
      assoc = described_class.reflect_on_association(:borrows)
      expect(assoc.macro).to eq :has_many
    end

    it 'has many books through borrows' do
      assoc = described_class.reflect_on_association(:books)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe 'methods' do
    before do
      @user = User.create(email: 'test@example.com', password: 'password')
      @book1 = Book.create(title: 'Book 1', author: 'Author 1', genre: 'Genre 1', isbn: '1234567890', total_copies: 5)
      @book2 = Book.create(title: 'Book 2', author: 'Author 2', genre: 'Genre 2', isbn: '0987654321', total_copies: 3)
      @borrow1 = Borrow.create(user: @user, book: @book1, due_date: Date.today - 1, return_date: nil)
      @borrow2 = Borrow.create(user: @user, book: @book2, due_date: Date.today + 1, return_date: nil)
    end

    describe '#fetch_borrows_with_books' do
      it 'returns borrows with books that are not returned' do
        result = @user.fetch_borrows_with_books
        expect(result).to include(@borrow1, @borrow2)
      end
    end

    describe '.with_overdue_books' do
      it 'returns users with overdue books' do
        result = User.with_overdue_books
        expect(result).to include(@user)
      end
    end
  end
end