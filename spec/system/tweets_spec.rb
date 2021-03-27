require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "ツイート投稿", type: :system do
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
end

RSpec.describe "ツイート編集", type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
    sleep(1)
  end

  context '自分が投稿した記事の編集ができる' do
    it '自分が投稿した記事ならば編集ができる' do
      # Basic認証の入力をする
      basic_pass

      # ツイート2を投稿したユーザーがログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @tweet2.user.email
      fill_in 'user[password]', with: @tweet2.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)

      # ツイート2をクリックする
      page.first("img[src$='inko-sample.png']").click

      # ツイート2の詳細ページに遷移したことを確認する 
      expect(current_path).to eq(tweet_path(@tweet2.id))

      # 編集ページへのリンクがあることを確認する
      expect(page).to have_content('記事の編集')

      # 記事の編集をクリックする
      click_link '記事の編集'

      # ツイート2の編集ページに遷移したことを確認する
      expect(current_path).to eq(edit_tweet_path(@tweet2.id))

      # 既に投稿済みの内容が入力されていることを確認する
      expect(
        find('#tweet-title').value
      ).to eq(@tweet2.title)
      expect(
        find('#tweet-article').value
      ).to eq(@tweet2.article)
      expect(
        find('#tweet-category').value
      ).to eq"#{@tweet2.category_id}"
      expect(
        find('#tweet-prefecture').value
      ).to eq"#{@tweet2.prefecture_id}"
      expect(
        find('#tweet-city').value
      ).to eq(@tweet2.city)

      # ツイートを編集する
      attach_file 'tweet[image]', "app/assets/images/inko-logo.png"
      fill_in 'tweet[title]', with: "#{@tweet2.title}+編集したタイトル"
      fill_in 'tweet[article]', with: "#{@tweet2.article}+編集した記事"
      select 'ショップ', from: 'tweet-category'
      select '沖縄', from: 'tweet-prefecture'
      fill_in 'tweet[city]', with: "#{@tweet2.city}+編集した市町村"

      # 編集してもTweetモデルのカウントが変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(0)

      # ツイートの詳細ページに遷移したことを確認する
      expect(current_path).to eq(tweet_path(@tweet2.id))

      # ツイートの編集内容が反映されていることを確認する(画像)
      expect(page).to have_selector"img[src$='inko-logo.png']"

      # ツイートの編集内容が反映されていることを確認する(テキスト)
      expect(page).to have_content(@tweet2_title)

      # トップページへ遷移する
      visit root_path

      # 編集したツイートがトップページにあることを確認する(画像) 
      expect(page).to have_selector"img[src$='inko-logo.png']"

      # 編集したツイートがトップページにあることを確認する(テキスト)
      expect(page).to have_content(@tweet2_title)
    end
  end

  context '他の人が投稿した記事は編集できない' do
    it '自分が投稿した記事ではないならば編集はできない' do
      # ツイート1を投稿したユーザーがログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @tweet1.user.email
      fill_in 'user[password]', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)

      # ツイート2をクリックする
      page.first("img[src$='inko-sample.png']").click      

      # ツイート2の詳細ページに遷移したことを確認する 
      expect(current_path).to eq(tweet_path(@tweet2.id))

      # 編集ページへのリンクがないことを確認する
      expect(page).to have_no_content('記事の編集')
    end

    it 'ログインしていないと記事の編集はできない' do
      # トップページに遷移する
      visit root_path

      # ツイート2をクリックする
      page.first("img[src$='inko-sample.png']").click            
      
      # ツイート2の詳細ページに遷移したことを確認する 
      expect(current_path).to eq(tweet_path(@tweet2.id))

      # 編集ページへのリンクがないことを確認する
      expect(page).to have_no_content('記事の編集')
    end
  end
end

