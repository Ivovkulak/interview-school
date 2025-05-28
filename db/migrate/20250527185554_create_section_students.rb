class CreateSectionStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :section_students do |t|
      t.references :section, null: false, foreign_key: true, index: true
      t.references :student_profile, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
