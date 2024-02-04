class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets do |t|
      t.integer :column, limit: 1, null: false, comment: "座席の列"
      t.string :row, limit: 1, null: false, comment: "座席の行"

      t.timestamps
   end
  end
end
