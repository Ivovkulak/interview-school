class CreateSections < ActiveRecord::Migration[7.2]
  def change
    create_table :sections do |t|
      t.references :subject, null: false, foreign_key: true, index: true
      t.references :classroom, null: false, foreign_key: true, index: true
      t.references :teacher_profile, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
