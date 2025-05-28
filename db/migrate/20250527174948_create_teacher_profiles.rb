class CreateTeacherProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :teacher_profiles do |t|
      t.timestamps
    end
  end
end
