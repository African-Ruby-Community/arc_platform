class AddTimezoneToEvents < ActiveRecord::Migration[8.1]
  def change
    # Check if column already exists before adding
    unless column_exists?(:events, :timezone)
      add_column :events, :timezone, :string, default: 'UTC'
    end
  end
end
