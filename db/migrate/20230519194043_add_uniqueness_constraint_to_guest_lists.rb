class AddUniquenessConstraintToGuestLists < ActiveRecord::Migration[7.0]
  def change
    add_index :guest_lists, [:attended_event_id, :attendee_id], unique: true
  end
end
