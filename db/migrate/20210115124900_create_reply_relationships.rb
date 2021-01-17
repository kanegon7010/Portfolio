class CreateReplyRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :reply_relationships do |t|
      t.references :main_micropost, foreign_key: {to_table: :microposts}
      t.references :reply_micropost, foreign_key: {to_table: :microposts}

      t.timestamps
    end
  end
end
