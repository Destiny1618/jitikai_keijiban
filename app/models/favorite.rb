class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :favoriteable, polymorphic: true
  validates :customer_id, uniqueness: { scope: [:favoriteable_id, :favoriteable_type] }

end
