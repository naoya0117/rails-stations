class AddReferenceFromSchedules < ActiveRecord::Migration[6.1]
  def change
    add_reference :schedules, :screen, null: false, foreign_key: true, on_delete: :no_action, on_update: :no_action
    remove_index :reservations, name: "reservation_schedule_sheet_unique"
    add_index :reservations, [:schedule_id, :sheet_id], unique: true, name: "reservation_schedule_sheet_unique"
  end
end
