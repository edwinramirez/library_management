# spec/controllers/dashboard_controller_spec.rb

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'GET #home' do
    context 'when user is not an admin' do
      it 'assigns @borrows_with_books' do
        borrows_with_books = double('borrows_with_books')
        allow(user).to receive(:fetch_borrows_with_books).and_return(borrows_with_books)
        get :home
        expect(assigns(:borrows_with_books)).to eq(borrows_with_books)
      end
    end

    context 'when user is an admin' do
      before do
        sign_in admin
      end

      it 'assigns @total_books' do
        total_books = 10
        allow(Book).to receive(:sum_total_copies).and_return(total_books)
        get :home
        expect(assigns(:total_books)).to eq(total_books)
      end

      it 'assigns @total_borrowed_books' do
        total_borrowed_books = 5
        allow(Borrow).to receive(:total_borrowed_books).and_return(total_borrowed_books)
        get :home
        expect(assigns(:total_borrowed_books)).to eq(total_borrowed_books)
      end

      it 'assigns @books_due_today' do
        books_due_today = double('books_due_today')
        allow(Borrow).to receive(:due_today).and_return(books_due_today)
        get :home
        expect(assigns(:books_due_today)).to eq(books_due_today)
      end

      it 'assigns @members_with_overdue_books' do
        members_with_overdue_books = double('members_with_overdue_books')
        allow(User).to receive(:with_overdue_books).and_return(members_with_overdue_books)
        get :home
        expect(assigns(:members_with_overdue_books)).to eq(members_with_overdue_books)
      end

      it 'assigns @borrowed_books_by_due_date' do
        borrowed_books_by_due_date = double('borrowed_books_by_due_date')
        allow(Borrow).to receive(:borrowed_books_by_due_date).and_return(borrowed_books_by_due_date)
        get :home
        expect(assigns(:borrowed_books_by_due_date)).to eq(borrowed_books_by_due_date)
      end
    end
  end
end