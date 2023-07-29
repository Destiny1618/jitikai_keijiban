class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :jitikais, dependent: :destroy
  has_many :dusts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :post_favorites, ->{ where(favoriteable_type: 'Post')}, class_name: 'Favorite'
  has_many :event_favorites, ->{ where(favoriteable_type: 'Event')}, class_name: 'Favorite'
  has_many :jitikai_favorites, ->{ where(favoriteable_type: 'Jitikai')}, class_name: 'Favorite'
  has_many :dust_favorites, ->{ where(favoriteable_type: 'Dust')}, class_name: 'Favorite'

  has_many :favorite_posts, through: :favorites, source_type: 'Post', source: :favoriteable
  has_many :favorite_events, through: :favorites, source_type: 'Event', source: :favoriteable
  has_many :favorite_jitikais, through: :favorites, source_type: 'Jitikai', source: :favoriteable
  has_many :favorite_dusts, through: :favorites, source_type: 'Dust', source: :favoriteable

  GUEST_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end

  def guest?
    email == GUEST_EMAIL
  end
end