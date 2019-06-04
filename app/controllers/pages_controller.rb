class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
  end

  def my_visits
    @all_flats = current_user.flats.order('id ASC')
    @flats_with_pending_rentals = @all_flats.joins(:rentals).where(rentals: { pending: true }).uniq
  end
end
