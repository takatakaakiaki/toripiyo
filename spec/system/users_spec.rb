require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができる' do
    it '正しい情報を入力するとユーザー新規登録ができてトップページに移動する' do
      # Basic認証の入力をする
      basic_pass

      # トップページに移動する
      visit root_path

      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name_kana]', with: @user.last_name_kana
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      select '1990', from: 'user_birthday_1i'
      select '3', from: 'user_birthday_2i'
      select '22', from: 'user_birthday_3i'

      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{  
        find('input[name="commit"]').click 
      }.to change { User.count }.by(1)

      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)

      # ログインページへ遷移するボタンと新規登録ページへ遷移するボタンがないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができない' do
    it '誤った情報を入力するとユーザー新規登録ができず新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path

      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      fill_in 'user[last_name]', with: ''
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name_kana]', with: ''
      fill_in 'user[first_name_kana]', with: ''
      select '1990', from: 'user_birthday_1i'
      select '3', from: 'user_birthday_2i'
      select '22', from: 'user_birthday_3i'      

      # 会員登録ボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)

      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end