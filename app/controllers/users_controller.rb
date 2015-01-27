class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :check_for_cancel, only: [:create, :update]
	before_action :authenticate, only: [:show, :edit, :update, :destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to new_user_profile_path(@user), notice: 'Thanks for joining in :)'
		else
			render action: :new
		end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to articles_path, notice: 'Your details have been udpated'
		else
			render action: 'edit'
		end
	end

	private

	def set_user
		@user = current_user
	end

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end

	def check_for_cancel
      if params[:commit] == 'Cancel'
        redirect_to articles_path
      end
    end

end
