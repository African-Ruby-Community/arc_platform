class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
