class CreateFeatureFlags < ActiveRecord::Migration[7.0]
  def change
    create_table :feature_flags do |t|
      t.string :feature
      t.text :description
      t.boolean :enabled

      t.timestamps
    end
  end
end
