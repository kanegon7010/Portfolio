class CreateWorkExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :work_experiences do |t|
      t.references :cv, null: false, foreign_key: true
      t.text :description
      t.boolean :display, default: true, null: false

      t.timestamps
    end
  end
end
