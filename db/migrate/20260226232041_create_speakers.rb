class CreateSpeakers < ActiveRecord::Migration[8.1]
  def change
    create_table :speakers do |t|
      t.string :name
      t.text :bio
      t.references :event, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
