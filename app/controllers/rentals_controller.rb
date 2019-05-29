class RentalsController < ApplicationController
	before_action :set_flat, only: [:new, :create, :confirmation]


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
	  # TO TWEAK: IF OK ... else ...
	end

	private

	def rental_params
	  params.require(:rental).permit(:description, :start_date, :end_date, :initial_rent)
	end

	def set_flat
	  @flat = Flat.find(params[:flat_id])
	end

end
