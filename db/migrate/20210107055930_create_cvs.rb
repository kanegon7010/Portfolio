class CreateCvs < ActiveRecord::Migration[6.0]
  def change
    create_table :cvs do |t|
      t.belongs_to :user, null: false, index: { unique: true }, foreign_key: true
      t.string :education
      t.boolean :display, default: true, null: false

      t.timestamps
    end
  end
end
