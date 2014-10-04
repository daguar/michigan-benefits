require 'rails_helper'

describe Role do
  context 'invalid' do
    subject(:role) { Role.new }
    let(:existing_role) { create :role }

    before { is_expected.not_to be_valid }

    it 'requires name' do
      expect(role.errors[:name]).not_to be_empty
    end

    it 'requires key' do
      expect(role.errors[:key]).not_to be_empty
    end

    it 'requires a unique key' do
      role.key = existing_role.key
      is_expected.not_to be_valid
      expect(role.errors[:key]).not_to be_empty
    end
  end

  context 'valid' do
    subject(:role) { create :role }
    let(:account1) { create :account, email: 'user1@example.com' }
    let(:account2) { create :account, email: 'user2@example.com' }

    it 'can have accounts' do
      role.accounts = [account1, account2]
    end
  end
end
