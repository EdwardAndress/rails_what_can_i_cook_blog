class ProfilesController < ApplicationController
	before_action :set_user

	def show
	end

	def new
		@profile = Profile.new
	end

	def create
		@user.profile = Profile.new(profile_params)
		@user.profile.save
		session[:user_id] = @user.id
		render action: :show
	end

	def edit
	end

	def update
		@user.profile.save
		render action: :show
	end

	private

	def profile_params
		params.require(:profile).permit(:birthday, :bio, :color, :twitter, :name)
	end

	def set_user
		@user = User.find(params[:user_id])
	end

end