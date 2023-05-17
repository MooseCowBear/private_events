class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :guest_lists, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :guest_lists

  def created_by?(user)
    self.creator_id == (user.try(:id) || user)
  end
end
