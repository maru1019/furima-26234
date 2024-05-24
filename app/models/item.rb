class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_sales_status
  belongs_to :item_shopping_fee_status
  belongs_to :prefecture
  belongs_to :item_scheduled_delivery

  validates :image, :item_name, :item_info, :item_price, :user, presence: true
  validates :item_price, numericality: { only_integer: true, message: 'is not a number' }
  validates :item_price, numericality: { greater_than_or_equal_to: 300, message: 'must be greater than or equal to 300' }
  validates :item_price, numericality: { less_than_or_equal_to: 9_999_999, message: 'must be less than or equal to 9999999' }
  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :item_category_id, :item_sales_status_id, :item_shopping_fee_status_id, :prefecture_id, :item_scheduled_delivery_id
  end
end
