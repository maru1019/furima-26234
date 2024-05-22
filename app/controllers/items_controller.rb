class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
  end

  private

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end

  def item_params
    params.require(:item).permit(:item_name, :image).merge(user_id: current_user.id)
  end
end
