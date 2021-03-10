class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    valedates :nickname
    valedates :birthday
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' } do
    valedates :first_name
    valedates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: '全角カタカナで入力してください' } do
    valedates :first_name_kana
    valedates :last_name_kana
  end
  
  









end
