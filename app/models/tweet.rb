class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :article
    validates :category_id
    validates :prefecture_id
    validates :city
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :prefecture_id
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture

  def self.search(search)
    if search != ""
      Tweet.where('article LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
