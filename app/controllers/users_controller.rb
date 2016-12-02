class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		# @image = MiniMagick::Image.open(@user.image.to_s)
		# @image = @image.path #=> "/var/folders/k7/6zx6dx6x7ys3rv3srh0nyfj00000gn/T/magick20140921-75881-1yho3zc.jpg"
		# @image = @image.resize "300x300"
		# @image = @image.format "png"
		# @image = @image.write "output.png"
	end

	def edit
		if current_user.id == User.find(params[:id]).id
			@user = User.find(params[:id])
		else 
			redirect_to root_path, notice: "You have no authorization to visit that page!"
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to root_path
	end

	private

		def user_params
			params.require(:user).permit(:email, :image)
		end
end
