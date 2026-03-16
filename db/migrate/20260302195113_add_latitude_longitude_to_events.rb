class AddLatitudeLongitudeToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :latitude, :decimal, precision: 10, scale: 8, if_not_exists: true
    add_column :events, :longitude, :decimal, precision: 11, scale: 8, if_not_exists: true
  end
end
