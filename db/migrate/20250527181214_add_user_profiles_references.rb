class AddUserProfilesReferences < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :teacher_profile, null: true, foreign_key: true, index: true
    add_reference :users, :student_profile, null: true, foreign_key: true, index: true
  end
end
