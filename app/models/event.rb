class Event < ApplicationRecord
  validates :name, presence: true
  validates :event_date, presence: true
  validates :event_time, presence: true
  validates :location, presence: true
  
  belongs_to :creator, class_name: "User"

  has_many :guest_lists, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :guest_lists

  scope :upcoming, -> { where("event_date >= ?", Date.today) } 
  scope :past, -> { where("event_date < ?", Date.today)}

  def created_by?(user)
    self.creator_id == (user.try(:id) || user)
  end

  def upcoming?
    self.event_date.to_date >= Date.today
  end

  def past?
    !upcoming?
  end
end
