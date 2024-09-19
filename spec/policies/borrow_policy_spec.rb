# spec/policies/borrow_policy_spec.rb

require 'rails_helper'

RSpec.describe BorrowPolicy, type: :policy do
  let(:user) { User.new }
  let(:admin) { User.new(admin: true) }
  let(:borrow) { Borrow.new }

  subject { described_class }

  permissions :show? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, borrow)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, borrow)
    end
  end

  permissions :create? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, borrow)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, borrow)
    end
  end

  permissions :update? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, borrow)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, borrow)
    end
  end

  permissions :destroy? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, borrow)
    end

    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, borrow)
    end
  end
end