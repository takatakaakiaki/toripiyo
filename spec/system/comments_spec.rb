require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "コメント送信", type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = Faker::Lorem.sentence
    sleep(1)
  end

  it 'ログインしたユーザーはコメントを送信できる' do
    # Basic認証の入力をする
    basic_pass

    # ログインする
    visit new_user_session_path
    fill_in 'user[email]', with: @tweet.user.email
    fill_in 'user[password]', with: @tweet.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)

    # ツイートの詳細ページに移動する 
    visit tweet_path(@tweet)

    # コメント欄にコメントを入力する
    fill_in 'comment[comment]', with: @comment

    # コメントを入力するとCommentモデルのカウントが1上がる
    expect {
      find('input[name="commit"]').click
    }.to change {Comment.count}.by(1)

    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(tweet_path(@tweet))

    # 詳細ページにコメントがあることを確認する
    expect(page).to have_content @comment
  end

  it 'ログインしていないユーザーはコメントを送信できない' do
    # ツイートの詳細ページに移動する 
    visit tweet_path(@tweet)

    # コメントを送信するボタンがないことを確認する
    expect(page).to have_no_content("コメントする")
  end
end
