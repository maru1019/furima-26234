class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
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

  def show
  end

  def edit
    return unless !user_signed_in? || @item.user_id != current_user.id # || @item.sold_out?
    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless current_user.id != @item.user_id
      @item.destroy
    end
    redirect_to root_path
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

  def set_item
    @item = Item.find(params[:id])
  end
end
