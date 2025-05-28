class CreateStudentProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :student_profiles do |t|
      t.timestamps
    end
  end
end
