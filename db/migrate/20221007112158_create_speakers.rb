class CreateSpeakers < ActiveRecord::Migration[7.0]
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :description
      t.belongs_to :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
