class Tweet < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :article
    validates :category_id
    validates :prefecture_id
    validates :city
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :prefecture_id
  end
end
