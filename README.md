# アプリケーション名

とりぴよ

こちらのアプリケーションは、インコ等小鳥の飼い主同士の情報交換や交流を目的に作成したものです。

お世話の方法や、事前にインコ等を診てくれる動物病院について共有したり、自分が飼っている子のかわいい画像を載せるサイトを自分で作ってみたい。という思いで作成しました。

# アプリケーション概要

① 皆さんの投稿した記事を閲覧することができます。

② ログインしているユーザーは記事を投稿できます。

③ ログインしているユーザーは自分が投稿した記事の編集や削除ができます。

④ カテゴリーを指定することで、そのカテゴリーに分類された記事を閲覧できます。

⑤ 検索窓に調べたいワードを入力すると、そのワードが記載されている記事を閲覧できます。

# URL

https://toripiyo.herokuapp.com/

# テスト用アカウント

メールアドレス taka@takapiyo

パスワード takapiyo13

Basic ID drdrpiyotaka

Basic pass 3927

# 利用方法

① 右上にある「新規登録」をクリックしてユーザー登録を行ってください。各項目を入力し、「会員登録」をクリックするとトップページに戻り、右上に自分のニックネームが表示されていれば成功です。

② 右下にある「投稿する」をクリックすることで記事の作成ページに遷移します。載せたい写真や画像を選択し、必要事項を入力した後、下にある「投稿する」をクリックするとトップページに遷移し、投稿した記事が表示されます。

③ 投稿されている記事をクリックすると、その記事の内容を閲覧できます。

④ 自分が投稿した記事ならば、「記事の編集」を押すことで記事の内容を変更できるページに遷移できます。「削除」を押すことでその記事を削除することができます。

⑤ 「記事の編集」を押すと編集ページに遷移します。変更したい内容を入力した後「変更する」を押すと、その記事のページに戻り、変更された内容が反映されています。

⑥ 左上にある「カテゴリー」を押すとプルダウンが表示されます。閲覧したいカテゴリーを押すとそのカテゴリーの記事だけが載ったページに遷移されます。

⑦ 右上の「ログアウト」を押すことでログアウトできます。

⑧ ログインする時は右上の「ログイン」を押してください。ログインページにてメールアドレスとパスワードを入力し、「ログイン」を押すことでログインができます。

# 目指した課題解決
ニュースで犬や猫に関する情報サイトの紹介を聞いたことがこのプリケーションを作成しようとしたきっかけです。普段は見慣れないインコの愛くるしい姿について知ってもらうことと、地域や飼っている鳥の種類によっては病気を診てくれる病院が限られてくるのではないか？と思い、情報の収集に役立てることができればと考え、作成しました。

# 洗い出した要件

| 優先順位(高:3,中:2,低:1) | 機能                    | 目的                              | 詳細                              | ストーリー                            | 実装見積もり |
| ---------------------- | ---------------------- | --------------------------------- | -------------------------------- | ----------------------------------- | ----------- |
| 3 | 画面遷移図              | 実装する機能と各ページの関係性を整理する |                                  |                                     | 4           |
| 3 | DB設計                 | 必要なデータと関係性を洗い出す         | users/tweets/comments             |                                    | 4           |
| 3 | ユーザー管理機能         | deviseを用いたユーザー管理機能の実装   | トップページ右上にある新規登録とログインを表示。ログイン時はユーザー名とログアウトを表示 | 記事を投稿したいユーザーはログインまたは新規登録をする必要がある | 8           |
| 3 | 記事の投稿機能          | 画像付きの記事を投稿できる機能を実装    | 必要事項を入力し、投稿するを押すことで記事の投稿ができる | 自分の飼っているインコの画像や発信したい情報などを入力して投稿できる | 8           |
| 3 | 記事の詳細閲覧機能       | 投稿されている記事の閲覧機能を実装      | 投稿されている記事をクリックすることでその記事の内容を閲覧できる | 他の人が投稿した記事を閲覧できる        | 5           |
| 3 | 記事の編集機能          | 投稿されている記事の編集機能を実装      | 自分が投稿した記事は、記事の編集を押すことで内容を変更できる | 間違えて投稿した記事の内容を修正できる   | 5            |
| 3 | コメント機能           | 投稿されている記事に対してコメントを送信できる機能を実装  | 記事の詳細ページにあるコメント欄にコメントを入力してコメントするをクリックすることでコメントが表示される | 投稿記事に関するユーザー同士の交流や情報の交換ができる | 6            |
| 2 | 記事の削除機能          | 投稿されている記事の削除機能を実装      | 自分が投稿した記事は、削除を押すことで削除することができる | 間違えて投稿した記事や不要な記事を削除できる  | 4           |
| 2 | カテゴリー毎のページ作成 | 投稿されている記事をカテゴリー毎に閲覧できる機能を実装  | 左上のカテゴリーをクリックするとプルダウン形式でカテゴリーが表示され、閲覧したいカテゴリーをクリックするとそのカテゴリーだけの記事が載っているページに遷移できる | 特定のカテゴリーに関する記事に絞って閲覧できる | 10           |
| 2 | 検索機能              | 投稿されている記事をキーワードで検索できる機能を実装  | 上部にある検索窓に調べたいワードを入力するとそのワードが記載されている記事が載ったページに遷移できる | 特定のワードが記載されている記事に絞って閲覧できる | 5            |


# 各機能のGIF

① ユーザー管理機能 

新規登録 https://gyazo.com/ac79ca4b081fa826b36d9592f0bd8d7d

ログイン https://gyazo.com/c5b36e6d533ad2d3926f5ba0e24560de

ログアウト https://gyazo.com/2cc59d9fe0b3b26398e062604137161f

② 記事の投稿機能 https://gyazo.com/2ef7f2d1290ef6791ac4e1323d5104f2
               https://gyazo.com/83d37bccd029cdd790b4574d7cffb9ae

③ 記事の詳細閲覧機能 https://gyazo.com/557599ceaf51b727add621903f0d1bd6

④ 記事の削除機能 https://gyazo.com/4af2bc1a2990e315bf32df6d86d0f4b1

⑤ 記事の編集機能 https://gyazo.com/098752287101a9d25cb1d559cc2d4572
               https://gyazo.com/3a8fd5825f8116ac33c77e00cbf280da

⑥ カテゴリー毎の記事 https://gyazo.com/82c62be8c947840564a3235a529d9478

⑦ 検索機能 https://gyazo.com/bb29e9758c47eb313dbbb59054edfaae
          https://gyazo.com/059193abd5d1fa3881414791e5b2b7f3

⑧ コメント機能 https://gyazo.com/f5f65f3303e91e1ba9e227b0ef179d6d 

# 実装予定の機能

記事をカテゴリーだけでなく、地域毎（都道府県毎）で閲覧できるようにする

# ER図
https://user-images.githubusercontent.com/78331379/111765933-48cb3800-88e8-11eb-885c-89006aae3bc5.png

# ローカルでの動作方法

% git clone https://github.com/takatakaakiaki/toripiyo.git

# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false              |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birthday           | date   | null: false              |

### Association

- has_many :tweets
- has_many :comments

## tweets テーブル

| Column        | Type       | Options           |
| ----------    | ------     | ----------------- |
| title         | string     | null: false       |
| article       | text       | null: false       |
| category_id   | integer    | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| user          | references | foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| comment | text       |                   |
| user    | references | foreign_key: true |
| tweet   | references | foreign_key: true |


### Association

- belongs_to :user
- belongs_to :tweet