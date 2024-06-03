FactoryBot.define do
  factory :item do
    association :user

    item_name { 'Test' }
    item_info { 'Test' }
    item_category_id { Faker::Number.between(from: 2, to: 11) }
    item_sales_status_id { Faker::Number.between(from: 2, to: 7) }
    item_shopping_fee_status_id { Faker::Number.between(from: 2, to: 4) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    item_scheduled_delivery_id { Faker::Number.between(from: 2, to: 3) }
    item_price { 1000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
