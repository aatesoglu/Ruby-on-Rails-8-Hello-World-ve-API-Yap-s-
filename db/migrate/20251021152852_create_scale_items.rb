class CreateScaleItems < ActiveRecord::Migration[8.0]
  def change
    create_table :scale_items do |t|
      t.text :content
      t.integer :item_type
      t.integer :order
      t.json :options
      t.references :scale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
