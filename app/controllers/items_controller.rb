class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @user = current_user
    @item = @user.items.new(item_params)

    if @item.save
      flash[:notice] = "Success! Your item is now in the store!"
      redirect_to items_path
    else
      flash[:error] = "There was a problem saving your item"
      render :new
    end

  end

  def update

  end

  def destroy
    @item = Item.find(params[:id])

    if @item.destroy
      flash[:notice] = "Your item has been successfully destroyed"
      redirect_to items_path
    else
      flash[:error] = "Your item could not be successfully destroyed"
      render :index
    end
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:title, :public_description, :internal_description, :sale_price, :purchase_price, :store_name, :street_address, :city, :state, :country, :zip, :user, :avatar)
  end
end
