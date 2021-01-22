class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :visitor, null: false, foreign_key: {to_table: :users}
      t.references :visited, null: false, foreign_key: {to_table: :users}
      t.references :main_micropost, foreign_key: {to_table: :microposts}
      t.references :reply_micropost, foreign_key: {to_table: :microposts}
      t.references :message, foreign_key: {to_table: :messages}
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
