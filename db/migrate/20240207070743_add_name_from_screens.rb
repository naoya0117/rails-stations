class AddNameFromScreens < ActiveRecord::Migration[6.1]
  def change
    remove_reference :screens, :sheet
    add_column :screens, :name, :string, null: false, limit: 50, comment: 'スクリーン名'
  end
end
