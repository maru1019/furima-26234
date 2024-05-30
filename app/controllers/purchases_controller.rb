class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @purchases_shipments = PurchaseShipment.new
  end

  def new
    @purchases_shipments = PurchaseShipment.new
  end

  def create
    @purchases_shipments = PurchaseShipment.new(purchases_params)
    if @purchases_shipments.valid?
      @purchases_shipments.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
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
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
