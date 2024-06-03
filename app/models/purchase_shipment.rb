class PurchaseShipment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  with_options presence: true do
    validates :post_code, :city, :addresses, :phone_number, :user_id, :item_id, :token, :prefecture_id
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :phone_number, numericality: { only_integer: true, message: 'is invalid. input only number' }
  validates :phone_number, length: { in: 10..11, message: 'is too short' }
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }

  def save
    purchase = Purchase.create(item_id:, user_id:)
    Shipment.create(
      post_code:,
      prefecture_id:,
      city:,
      addresses:,
      building:,
      phone_number:,
      purchase_id: purchase.id
    )
  end
end
