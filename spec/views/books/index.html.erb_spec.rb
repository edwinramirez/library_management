require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        title: "Title",
        author: "Author",
        genre: "Genre",
        isbn: "Isbn",
        total_copies: "Total Copies"
      ),
      Book.create!(
        title: "Title",
        author: "Author",
        genre: "Genre",
        isbn: "Isbn",
        total_copies: "Total Copies"
      )
    ])
  end

  it "renders a list of books" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Author".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Genre".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Isbn".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Total Copies".to_s), count: 2
  end
end
