class AddServiceidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :service_id, :string, null: false, default: ""
    change_column_null :users, :username, true

    add_index :users, :service_id,   unique: true
    remove_index :users, :username

  end
end
