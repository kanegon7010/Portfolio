class CreateSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :summaries do |t|
      t.references :cv, null: false, foreign_key: true
      t.string :name
      t.boolean :display, default: true, null: false

      t.timestamps
    end
  end
end
