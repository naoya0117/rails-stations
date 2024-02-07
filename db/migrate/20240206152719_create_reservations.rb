class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.references :schedule, null: false, foreign_key: true, on_delete: :no_action, on_update: :no_action
      t.references :sheet, null: false, foreign_key: true, on_delete: :no_action, on_update: :no_action
      t.string :email, null: false, limit: 255, comment: '予約者メールアドレス'
      t.string :name, null: false, limit: 50, comment: '予約者名'

      t.timestamps
    end

    add_index :reservations, :schedule_id, name: 'reservation_schedule_id_idx'
    add_index :reservations, :sheet_id, name: 'reservation_sheet_id_idx'
    add_index :reservations, %i[date schedule_id sheet_id], unique: true, name: 'reservation_schedule_sheet_unique'
  end
end
