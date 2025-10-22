class CreateSurveys < ActiveRecord::Migration[8.0]
  def change
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.integer :distribution_mode
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.text :settings, default: "{}"      # SQLite3 uyumlu
      t.references :project, null: false, foreign_key: true
      t.references :scale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
