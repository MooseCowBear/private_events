class RemoveEventDateFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :event_date, :datetime
  end
end
