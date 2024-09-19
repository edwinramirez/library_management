class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :book_is_available, on: :create
  validate :user_has_single_borrowed_copy, on: :create

  def book_is_available
    total_amount = Book.find(book_id).total_copies
    borrowed_amount = Borrow.where(book_id: book_id, return_date: nil).count

    if borrowed_amount >= total_amount
      errors.add(:book, 'is not available for borrowing')
    end
  end

  def user_has_single_borrowed_copy
    borrowed_books = Borrow.where(
      user_id: user_id,
      book_id: book_id,
      return_date: nil
    ).count

    if borrowed_books >= 1
      errors.add(:user, 'has already borrowed this book')
    end
  end

  def self.total_borrowed_books
    where(return_date: nil).count
  end

  def self.due_today
    where(due_date: Date.today).includes(:book)
  end

  def self.borrowed_books_by_due_date
    where(return_date: nil).includes(:book, :user).order(due_date: :desc)
  end
end
