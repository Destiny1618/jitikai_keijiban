class EventComment < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true
  belongs_to :event

  validates :comment, presence: true
end
