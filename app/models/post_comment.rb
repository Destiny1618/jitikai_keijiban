class PostComment < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true
  belongs_to :post

  validates :comment, presence: true
end
