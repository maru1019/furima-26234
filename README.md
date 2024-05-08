# テーブル設計

## users テーブル

| Column                | Type    | Options     |
| --------------------- | --------| ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false |
| last_name             | string  | null: false |
| first_name            | string  | null: false |
| last_name_kana        | string  | null: false |
| first_name_kana       | string  | null: false |
| birth_day             | date    | null: false |

### Association

- has_many :items
- has_one  :purchases

## items テーブル

| Column                      | Type    | Options     |
| --------------------------- | ------- | ----------- |
| item_name                   | string  | null: false |
| item_info                   | text    | null: false |
| item_category_id            | integer | null: false |
| item_sales-status_id        | integer | null: false |
| item_shopping-fee-status_id | integer | null: false |
| item_prefecture_id          | integer | null: false |
| item_scheduled-delivery_id  | integer | null: false |
| item_price                  | integer | null: false |
| add_tax_price               | integer | null: false |
| profit                      | integer | null: false |
| user_id                     | string  | null: false, foreign_key: true|

### Association

- belongs_to :user
- has_one  :purchases


## purchases テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| user_id    | integer | null: false, foreign_key: true|
| item_id    | integer | null: false, foreign_key: true|

### Association

- has_one :shipments
- belongs_to :user
- belongs_to :item

## shipments テーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| post_code_id  | integer |             |
| prefecture_id | integer | null: false |
| city          | string  | null: false |
| addresses     | string  | null: false |
| building      | string  | null: false |
| phone-number  | string  | null: false |
| purchases_id  | string  | null: false, foreign_key: true |

### Association

- belongs_to :purchase
