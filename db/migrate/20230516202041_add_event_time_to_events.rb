class AddEventTimeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_time, :string
  end
end
