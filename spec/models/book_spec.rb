require 'rails_helper'

RSpec.describe Book, type: :model do
  # Assuming the Book model has the following attributes: title, author, published_date

  describe 'validations' do
    it 'is valid with valid attributes' do
      book = Book.new(title: 'Sample Book', author: 'Author Name', published_date: Date.today)
      expect(book).to be_valid
    end

    it 'is not valid without a title' do
      book = Book.new(author: 'Author Name', published_date: Date.today)
      expect(book).not_to be_valid
    end

    it 'is not valid without an author' do
      book = Book.new(title: 'Sample Book', published_date: Date.today)
      expect(book).not_to be_valid
    end

    it 'is not valid without a published_date' do
      book = Book.new(title: 'Sample Book', author: 'Author Name')
      expect(book).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many borrows' do
      assoc = described_class.reflect_on_association(:borrows)
      expect(assoc.macro).to eq :has_many
    end

    it 'has many users through borrows' do
      assoc = described_class.reflect_on_association(:users)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe '.search_by_filter' do
    before do
      @book1 = Book.create(title: 'Ruby Programming', author: 'John Doe', genre: 'Programming', isbn: '1234567890', total_copies: 5)
      @book2 = Book.create(title: 'JavaScript Essentials', author: 'Jane Smith', genre: 'Programming', isbn: '0987654321', total_copies: 3)
      @book3 = Book.create(title: 'Cooking 101', author: 'Chef Ramsey', genre: 'Cooking', isbn: '1122334455', total_copies: 2)
    end

    it 'returns books that match the query in title' do
      result = Book.search_by_filter('Ruby')
      expect(result).to include(@book1)
      expect(result).not_to include(@book2, @book3)
    end

    it 'returns books that match the query in author' do
      result = Book.search_by_filter('Jane')
      expect(result).to include(@book2)
      expect(result).not_to include(@book1, @book3)
    end

    it 'returns books that match the query in genre' do
      result = Book.search_by_filter('Cooking')
      expect(result).to include(@book3)
      expect(result).not_to include(@book1, @book2)
    end

    it 'returns an empty result when no books match the query' do
      result = Book.search_by_filter('Nonexistent')
      expect(result).to be_empty
    end
  end
end