FactoryBot.define do
  factory :item do
    item_name { 'Test' }
    item_info { 'Test' }
    item_category_id { 2 }
    item_sales_status_id { 2 }
    item_shopping_fee_status_id { 2 }
    prefecture_id { 2 }
    item_scheduled_delivery_id { 2 }
    item_price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

