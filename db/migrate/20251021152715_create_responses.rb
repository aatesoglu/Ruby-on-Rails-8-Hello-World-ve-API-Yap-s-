class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.string :participant_id
      t.json :response_data
      t.datetime :completed_at
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
