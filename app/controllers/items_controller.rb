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
    @user = User.find(params[:id])
    @item = Item.new

    if @item.save
      flash[:notice] = "Success! Your item is now in the store!"
      redirect_to items_path
    else
      flash[:error] = "There was a problem saving your item"
      render :new
    end

  end

  def destroy
  end

  def edit
  end

  private

  params.require(:item).allow(:title, :public_description, :internal_description, :sale_price, :purchase_price, :store_name, :street_address, :city, :state, :country, :zip, :user)
end
