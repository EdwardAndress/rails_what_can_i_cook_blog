class SessionsController < ApplicationController

	def create
		if user = User.authenticate(params[:email], params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: "Logged in successfully as #{user.name}"
		else
			flash.now[:alert] = "Either your username or password was entered incorrectly"
			render action: 'new'
		end
	end

	def destroy
		reset_session
		redirect_to root_path, notice: 'Goodbye!'
	end

end
