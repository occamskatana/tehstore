class FavoritesController < ApplicationController
  
  before_action :authenticate_user!

  def create
  	item = Item.find(params[:item_id])
  	favorite = current_user.favorites.build(item: item)

  	if favorite.save
  		flash[:notice] = "Favorited!"
  	else
  		flash[:error] = "There was a problem favoriting your item"
  	end

    redirect_to :back
  	
  end

  def destroy
  	item = Item.find(parms[:item_id])
  	favorite = current_user.favorites.find(params[:id])

  	if favorite.destroy
  		flash[:notice] = "Unfavorited"
  	else
  		flash[:error] = "There was a problem unfavoriting"
  	end

  	redirect_to :back
  end
end
