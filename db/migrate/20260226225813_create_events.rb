class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.string :status, null: false, default: 'draft'
      t.string :event_type, null: false
      t.string :location_name
      t.decimal :latitude, precision: 10, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.string :payment_status, default: 'free'
      t.integer :price_cents, default: 0
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end

    add_index :events, :status
    add_index :events, :event_type
    add_index :events, :start_datetime
  end
end
