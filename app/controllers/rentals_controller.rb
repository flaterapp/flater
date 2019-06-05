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
    @flat = Flat.find(@rental.flat.id)
    @flat.update!(to_rent: true)
    # OPTIMIZE IF OK ... else ...
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

  def confirm_tenant
    @rental = Rental.find(params[:id])
    @flat = Flat.find(params[:flat_id])
    @selected_dossier = Dossier.find(params[:dossier_id])
    respond_to do |format|
      if @rental.update!(pending: false, tenant_id:@selected_dossier.candidate.id)
        format.html { redirect_to flats_path, notice: 'Rental was successfully updated.' }
        @flat.update!(to_rent: false)
        # format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:description, :start_date, :end_date, :initial_rent)
  end

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

end
