class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def item_params
    params.require(:item).permit( 
    :item_name, 
    :image, 
    :item_info, 
    :item_price, 
    :item_category_id, 
    :item_sales_status_id, 
    :item_shopping_fee_status_id, 
    :prefecture_id, 
    :item_scheduled_delivery_id
    ).merge(user_id: current_user.id)
  end
end
