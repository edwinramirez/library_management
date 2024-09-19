class DashboardController < ApplicationController
  def home
    if current_user && !current_user.admin?
      @borrows_with_books = current_user&.fetch_borrows_with_books
    elsif current_user&.admin?
      @total_books = Book.sum_total_copies
      @total_borrowed_books = Borrow.total_borrowed_books
      @books_due_today = Borrow.due_today
      @members_with_overdue_books = User.with_overdue_books
      @borrowed_books_by_due_date = Borrow.borrowed_books_by_due_date
    end
  end
end
