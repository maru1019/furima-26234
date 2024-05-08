# テーブル設計

## users テーブル

| Column                | Type    | Options     |
| --------------------- | --------| ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false, unique: true |
| password              | string  | null: false |
| password-confirmation | string  | null: false |
| last-name             | string  | null: false |
| first-name            | string  | null: false |
| last-name-kana        | string  | null: false |
| first-name-kana       | string  | null: false |
| user-birth-date1      | integer | null: false |
| user-birth-date2      | integer | null: false |
| user-birth-date3      | integer | null: false |

### Association

- has_many :items

## items テーブル

| Column                   | Type    | Options     |
| ------------------------ | ------- | ----------- |
| item-name                | string  | null: false |
| item-info                | text    | null: false |
| item-category            | string  | null: false |
| item-sales-status        | string  | null: false |
| item-shopping-fee-status | string  | null: false |
| item-prefecture          | string  | null: false |
| item-scheduled-delivery  | string  | null: false |
| item-price               | integer | null: false |
| add-tax-price            | integer | null: false |
| profit                   | integer | null: false |
| user_id                  | string  | null: false, foreign_key: true|

### Association

- belongs_to :users


## purchases テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| buyer      | strings | null: false |
| item-order | strings | null: false |

### Association

- has_one :shipments

## messages テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| post-code    | integer |             |
| prefecture   | string  | null: false |
| city         | string  | null: false |
| addresses    | string  | null: false |
| building     | string  | null: false |
| phone-number | integer | null: false |
| purchases_id | string  | null: false, foreign_key: true |

### Association

- belongs_to :purchases
