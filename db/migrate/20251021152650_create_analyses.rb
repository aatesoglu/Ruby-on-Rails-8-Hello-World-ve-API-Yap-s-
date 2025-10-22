class CreateAnalyses < ActiveRecord::Migration[8.0]
  def change
    create_table :analyses do |t|
      t.integer :analysis_type
      t.json :parameters
      t.json :results
      t.integer :status
      t.integer :credit_cost
      t.datetime :executed_at
      t.references :project, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
