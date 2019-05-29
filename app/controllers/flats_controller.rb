class FlatsController < ApplicationController
  def index
    @flats = Flat.where(owner_id: current_user)

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
