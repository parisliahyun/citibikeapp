class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
    render :index
  end


   def create
    @favorite = Favorite.new(favorites_params)
    current_user.favorites << @favorite
    if @favorite.save
      redirect_to user_favorites_path(current_user)

    else
      redirect_to user_path(current_user)
    end
  end

  private

# this is the white list engineering
  def favorites_params
    params.require(:favorite).permit(:address)
  end

end  
