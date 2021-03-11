class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'しぐさ' },
    { id: 3, name: '遊び' },
    { id: 4, name: '飼育用品' },
    { id: 5, name: 'おもちゃ' },
    { id: 6, name: 'エサ' },
    { id: 7, name: '睡眠' },
    { id: 8, name: 'ショップ' },
    { id: 9, name: '病院' },
    { id: 10, name: 'その他' },
  ]

  include ActiveHash::Associations
  has_many :tweets
end
