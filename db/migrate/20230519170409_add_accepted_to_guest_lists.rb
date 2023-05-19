class AddAcceptedToGuestLists < ActiveRecord::Migration[7.0]
  def change
    add_column :guest_lists, :accepted, :boolean, :default => false
  end
end
