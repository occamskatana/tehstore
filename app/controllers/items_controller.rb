class ItemsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    if params[:search]
      @items = Item.search(params[:search]).order("created_at DESC")
    elsif params[:sort]
      @items = Item.all.reorder(sort_column + " " + sort_direction)
    else
      @items = Item.all
    end
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

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[ASC DESC].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def item_params
    params.require(:item).permit(:tag_list, :title, :public_description, :internal_description, :sale_price, :purchase_price, :store_name, :street_address, :city, :state, :country, :zip, :user, :avatar)
  end
end
