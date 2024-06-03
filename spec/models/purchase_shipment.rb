require 'rails_helper'

RSpec.describe PurchaseShipment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @purchase_shipment = FactoryBot.build(:purchase_shipment, user_id: @user.id, item_id: @item.id)
  end
  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipment).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @purchase_shipment.building = ''
        expect(@purchase_shipment).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_shipment.post_code = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが3桁ハイフン4桁の半角文字列以外は保存できないこと' do
        @purchase_shipment.post_code = '1234-123'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_shipment.prefecture_id = 1
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @purchase_shipment.city = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空だと保存できないこと' do
        @purchase_shipment.addresses = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @purchase_shipment.phone_number = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値以外だと保存できないこと' do
        @purchase_shipment.phone_number = 'TEL'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid. input only number')
      end
      it 'phone_numberが9桁以下12桁以上だと保存できないこと' do
        @purchase_shipment.phone_number = '123456789'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end
      it 'phone_numberが9桁以下12桁以上だと保存できないこと' do
        @purchase_shipment.phone_number = '012345678901'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_shipment.user_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_shipment.item_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @purchase_shipment.token = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
