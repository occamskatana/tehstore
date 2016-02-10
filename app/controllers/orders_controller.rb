class OrdersController < ApplicationController
  def new
  	@item = Item.find(params[:item_id])
  	@order = @item.orders.new
  end

  def create
  	@item = Item.find(params[:item_id])
  	@order = @item.orders.create(item_id: @item.id, fulfilled: false, user_id: current_user.id)
  	@order.save

    flash[:notice] = "Your order for #{@item.title} is being fulfilled"
    redirect_to root_path
  end

  def index
    
    if !current_user
      flash[:error] = "Not authorized"
      redirect_to root_path
    else current_user && current_user.fulfiller? || current_user.admin?
      @orders = Order.all
    end
  end

  private

  def order_params
  	params.require(:order).permit(:item, :fulfilled)
  end
end
