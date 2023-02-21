class Event < ApplicationRecord
  validates :start_date, presence: true, inclusion: { in: (Time.current..) }
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, divisible_by: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, inclusion: { in: 1..1000 }
  validates :location, presence: true

  belongs_to :admin, class_name: "User"
  has_many :participations
  has_many :participants, through: :participations, source: :user
end
