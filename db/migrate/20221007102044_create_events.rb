class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :event_type
      t.string :location
      t.integer :cost
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :chapter, null: false, foreign_key: true 

      t.timestamps
    end
  end
end
