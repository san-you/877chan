class CreateCategorySettings < ActiveRecord::Migration[5.2]
  def change
    create_table :category_settings do |t|
      t.references :board, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
