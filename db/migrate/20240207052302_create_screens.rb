class CreateScreens < ActiveRecord::Migration[6.1]
  def change
    create_table :screens do |t|
      t.references :sheet, null: false, foreign_key: true, on_delete: :no_action, on_update: :no_action
      t.timestamps
    end
  end
end
