class Jitikai < ApplicationRecord
  has_one_attached :image
  belongs_to :admin
  belongs_to :customer, optional: true
  has_many :favorites, as: :favoriteable, dependent: :destroy
  scope :published, -> {where(is_published_flag: true)}
  scope :unpublished, -> {where(is_published_flag: false)}

  def favorited_by?(user,type)
    if type == :admin
      return favorites.exists?(admin_id: user.id)
    elsif type == :customer
      return favorites.exists?(customer_id: user.id)
    end
    false
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
      @jitikai = Jitikai.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @jitikai = Jitikai.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @jitikai = Jitikai.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @jitikai = Jitikai.where("title LIKE?","%#{word}%")
    else
      @jitikai = Jitikai.all
    end

  end

end
