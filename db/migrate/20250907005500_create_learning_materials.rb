# frozen_string_literal: true

class CreateLearningMaterials < ActiveRecord::Migration[7.2]
  def change
    # Guard against existing table to avoid PG::DuplicateTable in environments where
    # the table was created previously (e.g., manual setup or earlier branch).
    return if table_exists?(:learning_materials)

    create_table :learning_materials do |t|
      t.string :title, null: false
      t.integer :level, null: false, default: 0
      t.string :thumbnail
      t.string :link, null: false
      t.boolean :featured, null: false, default: false
      t.text :description

      t.timestamps
    end

    add_index :learning_materials, :level
    add_index :learning_materials, :featured
    add_index :learning_materials, :title
  end
end
