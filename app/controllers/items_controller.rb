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

  def edit 
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.assign_attributes(item_params)

    if @item.save
      flash[:notice] = "Your item was saved"
      redirect_to @item
    else
      flash[:error] = "Your item could not be saved"
      render :edit
    end
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

  private

  def item_params
    params.require(:item).permit(:title, :public_description, :internal_description, :sale_price, :purchase_price, :store_name, :street_address, :city, :state, :country, :zip, :user, :avatar)
  end
end
