class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :borrows, dependent: :destroy
  has_many :books, through: :borrows

  # A member fetches all their borrows
  def fetch_borrows_with_books
    borrows.includes(:book).where(return_date: nil)
  end

  # A librarian fetches all members with overdue books
  def self.with_overdue_books
    joins(:borrows).where('borrows.due_date <= ? AND borrows.return_date IS NULL', Date.today)
                   .distinct
  end
end
