# spec/policies/book_policy_spec.rb

require 'rails_helper'

RSpec.describe BookPolicy, type: :policy do
  let(:user) { User.new }
  let(:admin) { User.new(admin: true) }
  let(:book) { Book.new }

  subject { described_class }

  permissions :show? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, book)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, book)
    end
  end

  permissions :create? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, book)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, book)
    end
  end

  permissions :update? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, book)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, book)
    end
  end

  permissions :destroy? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, book)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, book)
    end
  end
end