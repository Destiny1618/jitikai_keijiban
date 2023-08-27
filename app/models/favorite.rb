class Favorite < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true
  belongs_to :favoriteable, polymorphic: true
  validates :customer_id, uniqueness: { scope: [:favoriteable_id, :favoriteable_type] }

end
