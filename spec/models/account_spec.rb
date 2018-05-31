require 'rails_helper'

RSpec.describe Account, type: :model do
  it do
    account = Account.create!(balance: 0)
    expect(account.balance).to eq(0)
  end
end
