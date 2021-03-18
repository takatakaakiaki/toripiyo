class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '普段の様子' },
    { id: 3, name: '飼育について' },
    { id: 4, name: '飼育用品' },
    { id: 5, name: 'おもちゃ' },
    { id: 6, name: 'ショップ' },
    { id: 7, name: '病院' },
    { id: 8, name: 'その他' },
  ]

  include ActiveHash::Associations
  has_many :tweets
end
