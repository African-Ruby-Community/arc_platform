class CreateUsersChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :users_chapters do |t|
      t.belongs_to :chapter, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :main_chapter, default: false

      t.timestamps
    end
  end
end
