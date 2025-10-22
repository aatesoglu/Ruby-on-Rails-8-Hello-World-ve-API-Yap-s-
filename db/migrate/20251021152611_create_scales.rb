class CreateScales < ActiveRecord::Migration[8.0]
  def change
    create_table :scales do |t|
      t.string :title
      t.text :description
      t.string :doi_identifier
      t.string :version
      t.string :language
      t.string :category
      t.integer :item_count
      t.text :metadata, default: "{}"   # SQLite3 uyumlu
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
