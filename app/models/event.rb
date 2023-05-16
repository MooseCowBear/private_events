class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  def created_by?(user)
    self.creator_id == (user.try(:id) || user)
  end
end
