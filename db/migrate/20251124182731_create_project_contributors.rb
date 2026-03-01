class CreateProjectContributors < ActiveRecord::Migration[8.0]
  def change
    create_table :project_contributors do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end

    add_index :project_contributors, [:project_id, :user_id], unique: true
  end
end
