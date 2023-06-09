class Event < ApplicationRecord
  validates :name, presence: true
  validates :event_date, presence: true
  validates :event_time, presence: true
  validates :location, presence: true

  belongs_to :creator, class_name: "User"

  has_many :guest_lists, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :guest_lists

  scope :upcoming, -> { where("event_date >= ?", Date.today).order("event_date") } 
  scope :past, -> { where("event_date < ?", Date.today).order("event_date") }
  scope :public_event, -> { where("private = ?", false) }

  scope :public_upcoming, -> { public_event.upcoming }
  scope :public_past, -> { public_event.past }

  def created_by?(user)
    self.creator_id == (user.try(:id) || user)
  end

  def formatted_date
    self.event_date.strftime('%D')
  end

  def formatted_time
    self.event_time.strftime('%l:%M %p')
  end

  def upcoming?
    self.event_date.to_date >= Date.today
  end

  def past?
    !upcoming?
  end

  def description?
    description && !description.empty?
  end

  def access_private?(user)
    return true unless self.private
    user && (self.attendees.exists?(id: user.id) || self.creator == user)
  end
end
