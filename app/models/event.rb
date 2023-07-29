class Event < ApplicationRecord
  has_one_attached :image
  belongs_to :admin, optional: true
  belongs_to :customer, optional: true
  has_many :event_comments, dependent: :destroy
  has_many :favorites, as: :favoriteable, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @event = Event.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @event = Event.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @event = Event.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @event = Event.where("title LIKE?","%#{word}%")
    else
      @event = Event.all
    end
  end

end
