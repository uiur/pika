class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :balance, default: 0, null: false

      t.timestamps
    end
  end
end
