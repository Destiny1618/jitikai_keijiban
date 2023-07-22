class EventComment < ApplicationRecord
  belongs_to :customer
  belongs_to :event

  validates :comment, presence: true
end
