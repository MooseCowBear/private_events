class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, foreign_key: :creator_id, class_name: "Event", dependent: :destroy

  has_many :guest_lists, foreign_key: :attendee_id
  has_many :attended_events, through: :guest_lists
end
