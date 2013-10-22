class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
    render :index
  end

  def show
    @favorite = Favorite.find(params[:id])
    render :show
  end

  def purchase
    @favorite = Favorite.find(params[:id])

    # put the below in the session helper
    # User.find_by(id: session[:user_id])
    if current_user.purchase(@song)
      redirect_to user_path(current_user)
    else
      render :show 
    end
  end

end  