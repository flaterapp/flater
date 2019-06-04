class RentalsController < ApplicationController
  before_action :set_flat, only: [:new, :create]

  def show
    @rental = Rental.find(params[:id])
    @flat = Flat.find(params[:flat_id])
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.pending = true
    @rental.flat = @flat
    @rental.save!
    # OPTIMIZE IF OK ... else ...
  end

  def organize_visit
    @rental = Rental.find(params[:id])
    @flat = Rental.find(params[:flat_id])
    @task = Task.new
    @invited_participants = @rental.dossiers.where(status: "ok_for_visit")
    @invited_participants.update(status: "visiting")
  end

	def organize_visit
	  @rental = Rental.find(params[:id])
	  @flat = Flat.find(params[:flat_id])
	  @task = Task.new
	  @invited_participants = @rental.dossiers.where(status: "ok_for_visit")
	end

  def select_tenant
    @rental = Rental.find(params[:id])
    @flat = Flat.find(params[:flat_id])
    @selected_dossier = Dossier.find(params[:dossier_id])
  end

  private

  def rental_params
    params.require(:rental).permit(:description, :start_date, :end_date, :initial_rent)
  end

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

end
