class Book < ApplicationRecord
  has_many :borrows, dependent: :destroy
  has_many :users, through: :borrows

  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :total_copies, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.search_by_filter(query)
    Book.where(
      "title LIKE :query OR author LIKE :query OR genre LIKE :query",
      { query: "%#{query}%" }
    )
  end

  def available_copies
    total_copies - borrows.where(return_date: nil).count
  end

  def self.sum_total_copies
    sum(:total_copies)
  end

end
