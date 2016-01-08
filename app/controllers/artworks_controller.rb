class ArtworksController < ApplicationController
 
 def new
    @artwork = Artwork.new
  end

  def create
    @artwork = current_user.artworks.build safe_create_params
    @artwork.category = Category.find_or_create_by(name: params[:category])

    if @artwork.save
      flash[:notice] = "Artwork added."
      redirect_to artwork_path(@artwork)
    else
      flash.now[:alert] = @artwork.errors.first
      render 'new'
    end
  end

  def favorite
    artwork = Artwork.find(params[:id])
    current_user.artworks << artwork
  end

  def show
    @artwork = Artwork.find params[:id]
  end


def safe_create_params
    params.require(:artwork).permit(:title, :price, :photo)
  end

end