class CreateLearningMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_materials do |t|
      t.references :user, null: false, foreign_key: true
      t.string :thumbnail
      t.integer :tag
      t.string :learning_material_title
      t.text :learning_material_description
      t.string :learning_material_link

      t.timestamps
    end
  end
end
