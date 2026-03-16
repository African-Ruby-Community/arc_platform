class AddSlugToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :slug, :string
    add_index :events, :slug, unique: true
  end
end
