class RenameFeatureToNameForFeatureFlags < ActiveRecord::Migration[7.0]
  def change
    rename_column :feature_flags, :feature, :name
  end
end
