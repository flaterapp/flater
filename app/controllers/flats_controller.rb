class FlatsController < ApplicationController
  def index
    @flats = Flat.where(owner_id: current_user)
    @markers = @flats.map do |flat|
      {
        id: flat.id,
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: render_to_string(partial: "flats/infowindow", locals: { flat: flat }),
        image_url: helpers.asset_url('ico_location.svg')
      }
    end
  end

  def show
    @flat = Flat.find(params[:id])
    @markers = {
      id: @flat.id,
      lat: @flat.latitude,
      lng: @flat.longitude,
      image_url: helpers.asset_url('ico_location.svg')
    }
  end
end
