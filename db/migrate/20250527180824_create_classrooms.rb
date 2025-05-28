class CreateClassrooms < ActiveRecord::Migration[7.2]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
