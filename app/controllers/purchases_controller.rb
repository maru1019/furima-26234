class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @purchases_shipments = PurchaseShipments.new
  end

  def new
    @purchase_shipment = PurchaseShipments.new
  end

  def create
    @purchase_shipment = PurchaseShipments.new(purchases_params)
    if @purchase_shipment.valid?
      @purchase_shipment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def purchases_params
    params.require(:purchases_shipments).permit(
      :post_code,
      :prefecture,
      :city,
      :addresses,
      :building,
      :phone_number
      ).merge(user_id: current_user.id)
  end
end
