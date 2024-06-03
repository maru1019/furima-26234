class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @purchase_shipment = PurchaseShipment.new
  end

  def new
    @purchase_shipment = PurchaseShipment.new
  end

  def create
    @purchase_shipment = PurchaseShipment.new(purchases_params)
    @item = Item.find(params[:item_id])
    if @purchase_shipment.valid?
      pay_item
      @purchase_shipment.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchases_params
    params.require(:purchase_shipment).permit(
      :post_code,
      :prefecture_id,
      :city,
      :addresses,
      :building,
      :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.item_price, # 商品の値段
      card: purchases_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
