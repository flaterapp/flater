class RentalsController < ApplicationController
	before_action :set_flat, only: [:new, :create, :confirmation]

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

	def confirmation
	  @rental = Rental.find(params[:rental_id])
	end
	private

	def rental_params
	  params.require(:rental).permit(:description, :start_date, :end_date, :initial_rent)
	end

	def set_flat
	  @flat = Flat.find(params[:flat_id])
	end

end
