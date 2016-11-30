class ReservationsController < ApplicationController

	def new
		@reservation = Reservation.new
		@listing = Listing.find(params[:listing_id])
	end

	def create

		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]

		@reservation.calculate_price
		
		if @reservation.save
		  @listing = Listing.find(params[:listing_id])	
		  redirect_to @listing
		else
		  #puts "\n\n[LOG] #{user.errors.full_messages}\n\n"
		  redirect_to root_path, notice: "Invalid form filling!"
		end
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def edit
		if current_user.id == Reservation.find(params[:id]).user_id
			@reservation = Reservation.find(params[:id])
		else 
			redirect_to root_path, notice: "You have no authorization to visit that page!"
		end
	end

	def update
		@reservation = Reservation.find(params[:id])
		if @reservation.update(reservation_params)
			redirect_to @reservation
		else
			render 'edit'
		end
	end

	def destroy
		Reservation.find(params[:id]).destroy
		redirect_to Listing.find(params[:listing_id])
	end

	private

		def reservation_params
			params.require(:reservation).permit(:user_id, :listing_id, :check_in, :check_out)
		end
end
