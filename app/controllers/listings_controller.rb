class ListingsController < ApplicationController

	def new
		@listing = Listing.new
	end

	def create
		byebug
		@listing = Listing.new(listing_params)
		@listing.user_id = current_user.id
		byebug

		if @listing.save
		  redirect_to @listing
		else
		  #puts "\n\n[LOG] #{user.errors.full_messages}\n\n"
		  redirect_to root_path, notice: "Invalid form filling!"
		end
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def edit
		if current_user.id == Listing.find(params[:id]).user_id
			@listing = Listing.find(params[:id])
		else 
			redirect_to root_path, notice: "You have no authorization to visit that page!"
		end
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to @listing
		else
			render 'edit'
		end
	end

	def destroy
		Listing.find(params[:id]).destroy
		redirect_to root_path
	end

	private

		def listing_params
			params.require(:listing).permit(:address, :price, :content)
		end
end
