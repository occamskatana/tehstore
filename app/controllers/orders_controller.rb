class OrdersController < ApplicationController
  def new
  	@item = Item.find(params[:item_id])
  	@order = @item.orders.new
  end

  def create
  	@item = Item.find(params[:item_id])
  	@order = @item.order.create(order_params)
  	@order.save
  end

  private

  def order_params
  	params.require(:order).permit(:item, :fulfilled)
  end
end
