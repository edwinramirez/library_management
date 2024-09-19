# spec/controllers/borrows_controller_spec.rb

require 'rails_helper'

RSpec.describe BorrowsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:borrow) { create(:borrow, user: user, book: book) }
  let(:valid_attributes) { { book_id: book.id, user_id: user.id } }
  let(:invalid_attributes) { { book_id: nil, user_id: nil } }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Borrow' do
        expect {
          post :create, params: { borrow: valid_attributes }
        }.to change(Borrow, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { borrow: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Borrow' do
        expect {
          post :create, params: { borrow: invalid_attributes }
        }.not_to change(Borrow, :count)
      end

      it 'redirects to the root path with unprocessable entity status' do
        post :create, params: { borrow: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested borrow' do
      borrow_to_destroy = create(:borrow, user: user, book: book)
      expect {
        delete :destroy, params: { id: borrow_to_destroy.to_param }
      }.to change(Borrow, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: borrow.to_param }
      expect(response).to redirect_to(root_path)
    end
  end
end