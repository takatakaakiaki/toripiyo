require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Tweets", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_title = Faker::Lorem.sentence
    @tweet_article = Faker::Lorem.sentence
    @tweet_city = Faker::Lorem.sentence
    sleep(1)
  end

  context 'ツイートの投稿ができる' do
    it 'ログインしたユーザーはツイートを投稿できる' do
      # Basic認証の入力をする
      basic_pass

      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)

      # 新規投稿ページへのリンクがあることを確認する  
      expect(page).to have_content('投稿する')

      # 新規投稿ページへ移動する
      visit new_tweet_path

      # ツイートの内容を入力する
      attach_file 'tweet[image]', "app/assets/images/inko-logo.png"
      fill_in 'tweet[title]', with: @tweet_title
      fill_in 'tweet[article]', with: @tweet_article
      select '飼育用品', from: 'tweet-category'
      select '北海道', from: 'tweet-prefecture'
      fill_in 'tweet[city]', with: @tweet_city

      # 投稿するとTweetモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(1) 

      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)

      # 記事が投稿されている(画像)
      expect(page).to have_selector"img[src$='inko-logo.png']"

      # 記事が投稿されている(テキスト)
      expect(page).to have_content(@tweet_title)
    end
  end

  context 'ツイートの投稿ができない' do
    it 'ログインしていないとツイートを投稿できない' do
      # トップページに遷移する
      visit root_path

      # 新規投稿ページへのリンクがあることを確認する  
      expect(page).to have_content('投稿する')

      # 新規投稿ページへ遷移するリンクをクリックする
      click_link '投稿する'

      # ログインページへ遷移することを確認する
      expect(current_path).to eq('/users/sign_in')
    end
  end

  context '' do






end
