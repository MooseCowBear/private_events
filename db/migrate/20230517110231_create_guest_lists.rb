class CreateGuestLists < ActiveRecord::Migration[7.0]
  def change
    create_table :guest_lists do |t|
      t.references :attended_event, null: false, foreign_key: {to_table: :events}
      t.references :attendee, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
