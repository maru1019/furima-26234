class PurchaseShipments
  include ActiveModel::Model
  attr_accessor :user, :item, :post_code, :prefecture_id, :city, :addresses, :building, :phone_number, :purchases

  with_options presence: true do
    validates :post_code, :city, :addresses, :building, :phone_number, :user_id
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
  validates :phone_number, numericality: { only_integer: true, message: 'is invalid. input only number' }
  validates :phone_number, length: { minimum: 10, message: "is too short" }
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }

  def save
    purchases = Purchases.create(item_id: item_id, user_id: user_id)
    Shipments.create(
      post_code: post_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      )
  end
end