class OrdersController < ApplicationController
  def new
  	@item = Item.find(params[:item_id])
  	@order = @item.orders.new
  end

  def create
  	@item = Item.find(params[:item_id])
  	@order = @item.orders.create(item_id: @item.id, user_id: current_user.id)
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

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.assign_attributes(order_params)

    if @order.save
      flash[:notice] = "Order status updated"
    else
      flash[:error] = "There was a problem saving the order status. Please contact an administrator"
    end
    redirect_to order_path(@order)
  end

  private

  def order_params
  	params.require(:order).permit(:item, :status, :user)
  end
end
