require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザーが新規登録できる' do
      it 'ニックネーム、メールアドレス、パスワード、パスワード（確認）、ユーザー本名、ユーザー本名フリガナ、生年月日が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザーが新規登録できない' do
      it 'ニックネームが空の場合は登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空の場合は登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '既に登録されているメールアドレスでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは@がないと登録できない' do
        @user.email = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが空の場合は登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが5文字以下の場合は登録できない' do
        @user.password = '111aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'パスワードが数字のみでは登録できない' do
        @user.password = 111_111
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'パスワードは全角文字では登録できない' do
        @user.password = '１１１１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'パスワード（確認）は空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードとパスワード（確認）は不一致だと登録できない' do
        @user.password = '111aaa'
        @user.password_confirmation = '111bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザー本名の名字が空の場合は登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'ユーザー本名の名前が空の場合は登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'ユーザー本名の名字は半角文字では登録できない' do
        @user.last_name = 'ababab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end

      it 'ユーザー本名の名前は半角文字では登録できない' do
        @user.first_name = 'bbbccc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it 'ユーザー本名フリガナの名字が空の場合は登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'ユーザー本名フリガナの名前が空の場合は登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'ユーザー本名フリガナの名字は全角カタカナでなければ登録できない' do
        @user.last_name_kana = '後藤'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナで入力してください')
      end

      it 'ユーザー本名フリガナの名前は全角カタカナでなければ登録できない' do
        @user.first_name_kana = '花子'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナで入力してください')
      end

      it '生年月日が空の場合は登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
