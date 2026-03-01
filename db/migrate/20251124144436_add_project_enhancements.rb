class AddProjectEnhancements < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :featured, :boolean, default: false, null: false
    add_column :projects, :owner_name, :string
    add_column :projects, :intro, :text
    add_column :projects, :preview_link, :string
    add_column :projects, :git_link, :string
    add_column :projects, :featured_order, :integer
    
    add_index :projects, :featured
  end
end
