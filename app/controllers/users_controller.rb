class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
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
			params.require(:user).permit(:email)
		end
end
