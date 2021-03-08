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