class RenameLearningMaterialsUrlColumns < ActiveRecord::Migration[7.2]
  def change
    if column_exists?(:learning_materials, :link_url)
      rename_column :learning_materials, :link_url, :link
    end

    if column_exists?(:learning_materials, :thumbnail_url)
      rename_column :learning_materials, :thumbnail_url, :thumbnail
    end
  end
end
