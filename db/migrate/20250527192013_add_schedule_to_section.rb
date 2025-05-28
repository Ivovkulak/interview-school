class AddScheduleToSection < ActiveRecord::Migration[7.2]
  def change
    change_table :sections, bulk: true do |t|
      t.time :monday_start, null: true
      t.time :monday_end, null: true
      t.time :tuesday_start, null: true
      t.time :tuesday_end, null: true
      t.time :wednesday_start, null: true
      t.time :wednesday_end, null: true
      t.time :thursday_start, null: true
      t.time :thursday_end, null: true
      t.time :friday_start, null: true
      t.time :friday_end, null: true
      t.time :saturday_start, null: true
      t.time :saturday_end, null: true
      t.time :sunday_start, null: true
      t.time :sunday_end, null: true
    end
  end
end
