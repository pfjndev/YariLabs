require 'securerandom'

class Bank
  
  def initialize
    # Hash to store user information by user ID
    @users = {}
    
    # Hash to store account information by account ID
    @accounts = {}
  end
  
  # Public API methods for accessing data (for testing purposes)
  def user_exists?(user_id)
    @users.key?(user_id)
  end
  
  def account_exists?(account_id)
    @accounts.key?(account_id)
  end
  
  def get_account_balance(account_id)
    return nil unless account_exists?(account_id)
    @accounts[account_id][:balance]
  end
  
  def get_user_accounts(user_id)
    return nil unless user_exists?(user_id)
    @users[user_id][:accounts]
  end
  
  def get_account_owner(account_id)
    return nil unless account_exists?(account_id)
    @accounts[account_id][:user_id]
  end

  def create_user(user_data)
    user_id = user_data[:id]
    
    return "User ID is required" if user_id.nil? || user_id.to_s.strip.empty?
    return "User #{user_id} already exists" if user_exists?(user_id)
    return "Password is required" if user_data[:password].nil? || user_data[:password].to_s.strip.empty?
    
    @users[user_id] = {
      id: user_id,
      name: user_data[:name]&.strip || 'Unknown',
      password: user_data[:password],
      accounts: []
    }
    
    "User #{user_id} created successfully"
  end

  def delete_user(user_id)
    return "User #{user_id} does not exist" unless user_exists?(user_id)
    
    # Get user's accounts before deletion
    user_accounts = @users[user_id][:accounts].dup
    
    # Delete all accounts associated with the user
    user_accounts.each { |account_id| @accounts.delete(account_id) }
    
    # Delete the user
    @users.delete(user_id)
    
    "User #{user_id} deleted successfully"
  end

  def create_account(user_id)
    return "User #{user_id} does not exist" unless user_exists?(user_id)
    
    account_id = generate_account_id
    
    @accounts[account_id] = {
      id: account_id,
      user_id: user_id,
      balance: 0.0,
      created_at: Time.now
    }
    
    # Add account to user's accounts list
    @users[user_id][:accounts] << account_id
    
    "Successfully created account for user #{user_id} with account ID #{account_id}"
  end

  def delete_account(account_id, user_id = nil)
    return "Account #{account_id} does not exist" unless account_exists?(account_id)
    
    account = @accounts[account_id]
    account_user_id = account[:user_id]
    
    # If user_id is provided, verify ownership
    if user_id && account_user_id != user_id
      return "Account #{account_id} does not belong to user #{user_id}"
    end
    
    # Remove account from user's accounts list
    @users[account_user_id][:accounts].delete(account_id)
    
    # Delete the account
    @accounts.delete(account_id)
    "Account #{account_id} deleted successfully"
  end

  def deposit(account_id, amount)
    return "Account #{account_id} does not exist" unless account_exists?(account_id)
    return "Deposit amount must be greater than zero" unless valid_amount?(amount)
    
    @accounts[account_id][:balance] += amount.to_f
    "Deposited #{amount} to account #{account_id}. New balance: #{@accounts[account_id][:balance]}"
  end

  def withdraw(account_id, amount)
    return "Account #{account_id} does not exist" unless account_exists?(account_id)
    return "Withdrawal amount must be greater than zero" unless valid_amount?(amount)
    
    current_balance = @accounts[account_id][:balance]
    return "Insufficient funds. Current balance: #{current_balance}" unless amount <= current_balance

    @accounts[account_id][:balance] -= amount.to_f
    "Withdrew #{amount} from account #{account_id}. New balance: #{@accounts[account_id][:balance]}"
  end

  def transfer(from_account_id, to_account_id, amount)
    return "Source account #{from_account_id} does not exist" unless account_exists?(from_account_id)
    return "Destination account #{to_account_id} does not exist" unless account_exists?(to_account_id)
    return "Transfer amount must be greater than zero" unless valid_amount?(amount)
    return "Cannot transfer to the same account" unless from_account_id != to_account_id
    
    from_balance = @accounts[from_account_id][:balance]
    return "Insufficient funds. Current balance: #{from_balance}" unless amount <= from_balance
    
    @accounts[from_account_id][:balance] -= amount.to_f
    @accounts[to_account_id][:balance] += amount.to_f
    
    "Transferred #{amount} from account #{from_account_id} to account #{to_account_id}. " \
    "New balances: From: #{@accounts[from_account_id][:balance]}, To: #{@accounts[to_account_id][:balance]}"
  end
  
  private
  
  def generate_account_id
    SecureRandom.alphanumeric(10).upcase
  end
  
  def valid_amount?(amount)
    amount.is_a?(Numeric) && amount > 0
  end
end