require 'rspec'
require_relative '../src/bank'

RSpec.describe Bank do
  let(:bank) { Bank.new }
  let(:user_data) { { id: '123', name: 'Alice', password: 'password', balance: 100.0 } }
  let(:user_data2) { { id: '456', name: 'Bob', password: 'password', balance: 50.0 } }

  describe '#create_user' do
    context 'with valid data' do
      it 'creates a user successfully' do
        result = bank.create_user(user_data)
        expect(result).to eq('User 123 created successfully')
        expect(bank.user_exists?('123')).to be true
        expect(bank.get_user_accounts('123')).to eq([])
      end
      
      it 'creates a user with default values when optional fields are missing' do
        minimal_data = { id: '789', password: 'password' }
        result = bank.create_user(minimal_data)
        expect(result).to eq('User 789 created successfully')
        expect(bank.user_exists?('789')).to be true
        expect(bank.get_user_accounts('789')).to eq([])
      end
    end
    
    context 'with invalid data' do
      it 'returns error when user ID is missing' do
        invalid_data = { name: 'Alice', password: 'password' }
        result = bank.create_user(invalid_data)
        expect(result).to eq('User ID is required')
      end
      
      it 'returns error when user ID is empty' do
        invalid_data = { id: '', name: 'Alice', password: 'password' }
        result = bank.create_user(invalid_data)
        expect(result).to eq('User ID is required')
      end
      
      it 'returns error when user already exists' do
        bank.create_user(user_data)
        result = bank.create_user(user_data)
        expect(result).to eq('User 123 already exists')
      end
      
      it 'returns error when password is missing' do
        invalid_data = { id: '123', name: 'Alice' }
        result = bank.create_user(invalid_data)
        expect(result).to eq('Password is required')
      end
      
      it 'returns error when password is empty' do
        invalid_data = { id: '123', name: 'Alice', password: '' }
        result = bank.create_user(invalid_data)
        expect(result).to eq('Password is required')
      end
    end
  end

  describe '#delete_user' do
    context 'when user exists' do
      it 'deletes the user successfully' do
        bank.create_user(user_data)
        result = bank.delete_user('123')
        expect(result).to eq('User 123 deleted successfully')
        expect(bank.user_exists?('123')).to be false
      end
      
      it 'deletes all associated accounts when deleting a user' do
        bank.create_user(user_data)
        account_result = bank.create_account('123')
        account_id = account_result.match(/account ID (\w+)/)[1]
        
        bank.delete_user('123')
        expect(bank.account_exists?(account_id)).to be false
      end
    end
    
    context 'when user does not exist' do
      it 'returns appropriate error message' do
        result = bank.delete_user('nonexistent')
        expect(result).to eq('User nonexistent does not exist')
      end
    end
  end

  describe '#create_account' do
    context 'when user exists' do
      it 'creates an account successfully' do
        bank.create_user(user_data)
        result = bank.create_account('123')
        expect(result).to match(/Successfully created account for user 123 with account ID \w+/)
        
        # Extract account ID from result message
        account_id = result.match(/account ID (\w+)/)[1]
        expect(bank.account_exists?(account_id)).to be true
        expect(bank.get_account_balance(account_id)).to eq(0.0)
      end
    end

    context 'when user does not exist' do
      it 'returns appropriate error message' do
        result = bank.create_account('nonexistent')
        expect(result).to eq('User nonexistent does not exist')
      end
    end
  end

  describe '#delete_account' do
    let(:account_id) do
      bank.create_user(user_data)
      result = bank.create_account('123')
      result.match(/account ID (\w+)/)[1]
    end
    
    context 'when account exists' do
      it 'deletes the account successfully' do
        result = bank.delete_account(account_id)
        expect(result).to eq("Account #{account_id} deleted successfully")
        expect(bank.account_exists?(account_id)).to be false
      end
      
      it 'verifies ownership when user_id is provided' do
        bank.create_user(user_data2)
        result = bank.delete_account(account_id, '456')
        expect(result).to eq("Account #{account_id} does not belong to user 456")
        expect(bank.account_exists?(account_id)).to be true
      end
    end

    context 'when account does not exist' do
      it 'returns appropriate error message' do
        result = bank.delete_account('nonexistent')
        expect(result).to eq('Account nonexistent does not exist')
      end
    end
  end

  describe '#deposit' do
    let(:account_id) do
      bank.create_user(user_data)
      result = bank.create_account('123')
      result.match(/account ID (\w+)/)[1]
    end
    
    context 'with valid parameters' do
      it 'deposits money successfully' do
        result = bank.deposit(account_id, 50.0)
        expect(result).to eq("Deposited 50.0 to account #{account_id}. New balance: 50.0")
        expect(bank.get_account_balance(account_id)).to eq(50.0)
      end
      
      it 'handles integer amounts' do
        result = bank.deposit(account_id, 100)
        expect(result).to eq("Deposited 100 to account #{account_id}. New balance: 100.0")
        expect(bank.get_account_balance(account_id)).to eq(100.0)
      end
    end
    
    context 'with invalid parameters' do
      it 'rejects negative amounts' do
        result = bank.deposit(account_id, -50.0)
        expect(result).to eq('Deposit amount must be greater than zero')
        expect(bank.get_account_balance(account_id)).to eq(0.0)
      end
      
      it 'rejects zero amounts' do
        result = bank.deposit(account_id, 0)
        expect(result).to eq('Deposit amount must be greater than zero')
      end
      
      it 'rejects non-numeric amounts' do
        result = bank.deposit(account_id, 'invalid')
        expect(result).to eq('Deposit amount must be greater than zero')
      end
      
      it 'rejects deposits to non-existent accounts' do
        result = bank.deposit('nonexistent', 50.0)
        expect(result).to eq('Account nonexistent does not exist')
      end
    end
  end

  describe '#withdraw' do
    let(:account_id) do
      bank.create_user(user_data)
      result = bank.create_account('123')
      account_id = result.match(/account ID (\w+)/)[1]
      bank.deposit(account_id, 100.0)
      account_id
    end
    
    context 'with valid parameters' do
      it 'withdraws money successfully' do
        result = bank.withdraw(account_id, 50.0)
        expect(result).to eq("Withdrew 50.0 from account #{account_id}. New balance: 50.0")
        expect(bank.get_account_balance(account_id)).to eq(50.0)
      end
      
      it 'allows withdrawing the full balance' do
        result = bank.withdraw(account_id, 100.0)
        expect(result).to eq("Withdrew 100.0 from account #{account_id}. New balance: 0.0")
        expect(bank.get_account_balance(account_id)).to eq(0.0)
      end
    end
    
    context 'with invalid parameters' do
      it 'rejects withdrawals exceeding balance' do
        result = bank.withdraw(account_id, 150.0)
        expect(result).to eq('Insufficient funds. Current balance: 100.0')
        expect(bank.get_account_balance(account_id)).to eq(100.0)
      end
      
      it 'rejects negative amounts' do
        result = bank.withdraw(account_id, -50.0)
        expect(result).to eq('Withdrawal amount must be greater than zero')
      end
      
      it 'rejects zero amounts' do
        result = bank.withdraw(account_id, 0)
        expect(result).to eq('Withdrawal amount must be greater than zero')
      end
      
      it 'rejects withdrawals from non-existent accounts' do
        result = bank.withdraw('nonexistent', 50.0)
        expect(result).to eq('Account nonexistent does not exist')
      end
    end
  end

  describe '#transfer' do
    let(:account_id1) do
      bank.create_user(user_data)
      result = bank.create_account('123')
      account_id = result.match(/account ID (\w+)/)[1]
      bank.deposit(account_id, 100.0)
      account_id
    end
    
    let(:account_id2) do
      bank.create_user(user_data2)
      result = bank.create_account('456')
      result.match(/account ID (\w+)/)[1]
    end

    context 'with valid parameters' do
      it 'transfers money between accounts successfully' do
        result = bank.transfer(account_id1, account_id2, 50.0)
        expect(result).to match(/Transferred 50.0 from account \w+ to account \w+/)
        expect(bank.get_account_balance(account_id1)).to eq(50.0)
        expect(bank.get_account_balance(account_id2)).to eq(50.0)
      end
    end
    
    context 'with invalid parameters' do
      it 'rejects transfers exceeding balance' do
        result = bank.transfer(account_id1, account_id2, 150.0)
        expect(result).to eq('Insufficient funds. Current balance: 100.0')
        expect(bank.get_account_balance(account_id1)).to eq(100.0)
        expect(bank.get_account_balance(account_id2)).to eq(0.0)
      end
      
      it 'rejects transfers to the same account' do
        result = bank.transfer(account_id1, account_id1, 50.0)
        expect(result).to eq('Cannot transfer to the same account')
      end
      
      it 'rejects negative amounts' do
        result = bank.transfer(account_id1, account_id2, -50.0)
        expect(result).to eq('Transfer amount must be greater than zero')
      end
      
      it 'rejects transfers from non-existent accounts' do
        result = bank.transfer('nonexistent', account_id2, 50.0)
        expect(result).to eq('Source account nonexistent does not exist')
      end
      
      it 'rejects transfers to non-existent accounts' do
        result = bank.transfer(account_id1, 'nonexistent', 50.0)
        expect(result).to eq('Destination account nonexistent does not exist')
      end
    end
  end

  describe 'helper methods' do
    let!(:account_id) do
      bank.create_user(user_data)
      result = bank.create_account('123')
      result.match(/account ID (\w+)/)[1]
    end
    
    describe '#get_user_accounts' do
      it 'returns user accounts list' do
        accounts = bank.get_user_accounts('123')
        expect(accounts).to include(account_id)
        expect(accounts.length).to eq(1)
      end
      
      it 'returns nil for non-existent user' do
        expect(bank.get_user_accounts('nonexistent')).to be_nil
      end
    end
    
    describe '#get_account_owner' do
      it 'returns the account owner' do
        owner = bank.get_account_owner(account_id)
        expect(owner).to eq('123')
      end
      
      it 'returns nil for non-existent account' do
        expect(bank.get_account_owner('nonexistent')).to be_nil
      end
    end
    
    describe 'account tracking' do
      it 'properly tracks accounts when creating them' do
        expect(bank.get_user_accounts('123')).to include(account_id)
      end
      
      it 'properly removes accounts from user list when deleting' do
        bank.delete_account(account_id)
        expect(bank.get_user_accounts('123')).not_to include(account_id)
      end
    end
  end
end