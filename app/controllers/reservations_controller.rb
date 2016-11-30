class ReservationsController < ApplicationController

	def new
		@reservation = Reservation.new
	end

	def create

		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id

		if @reservation.save
		  redirect_to @reservation
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
		redirect_to root_path
	end

	private

		def reservation_params
			params.require(:reservation).permit(:address, :price, :content)
		end
end
