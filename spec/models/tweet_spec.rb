require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe '記事の投稿' do
    context '記事が投稿できる場合' do
      it '記事の画像、タイトル、記事、カテゴリー、都道府県、市町村がある場合は記事を投稿できる' do
        expect(@tweet).to be_valid
      end
    end

    context '記事が投稿できない場合' do
      it 'タイトルが空の場合は投稿できない' do
        @tweet.title = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Title can't be blank")
      end

      it '記事が空の場合は投稿できない' do
        @tweet.article = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Article can't be blank")
      end

      it 'カテゴリーが空の場合は投稿できない' do
        @tweet.category_id = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Category can't be blank")
      end

      it 'カテゴリーがid:1の場合は投稿できない' do
        @tweet.category_id = 1
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('Category must be other than 1')
      end

      it '都道府県が空の場合は投稿できない' do
        @tweet.prefecture_id = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県がid:1の場合は投稿できない' do
        @tweet.prefecture_id = 1
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '市町村が空の場合は投稿できない' do
        @tweet.city = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("City can't be blank")
      end
    end
  end
end
