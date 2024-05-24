require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品の保存' do
    context '出品できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できないとき' do
      it 'imageが空では登録できない' do
        @item.image.purge
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
      it 'item_infoが空では登録できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item info can't be blank"
      end
      it 'category_idが0だと登録できない' do
        @item.item_category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item category can't be blank"
      end
      it 'item_sales_status_idが0だと登録できない' do
        @item.item_sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item sales status can't be blank"
      end
      it 'item_shopping_fee_status_idが0だと登録できない' do
        @item.item_shopping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item shopping fee status can't be blank"
      end
      it 'prefecture_idが0だと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'item_scheduled_delivery_idが0だと登録できない' do
        @item.item_scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Item scheduled delivery can't be blank"
      end
      it 'item_priceが空では登録できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item price can't be blank"
      end
      it 'item_priceが数字以外では登録できない' do
        @item.item_price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Item price is not a number'
      end
      it 'item_priceが300以下では登録できない' do
        @item.item_price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Item price must be greater than or equal to 300'
      end
      it 'item_priceが9999999以上では登録できない' do
        @item.item_price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Item price must be less than or equal to 9999999'
      end
      it 'userが紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
