class FlatsController < ApplicationController
  def index
    @flats = Flat.where(owner_id: current_user)
  end
end
