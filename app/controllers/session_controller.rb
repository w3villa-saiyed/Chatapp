class SessionController < ApplicationController
before_action :logged_in_redirect , only: [:new,:create]


def new

end

	def newsignup

	end

	def signup
		user_params =  {username: params[:username], password: params[:password]}
		@user = User.new(user_params)
		if @user.save
		  create

		flash[:success] = "You have successfully signup"
		redirect_to login_path
		else
			flash[:error] = "There was something wrong with your login information"
			binding.pry
			redirect_to '/newsignup'
		end
	end


def create
		
	 user = User.find_by(username: params[:session][:username])
	 
	 puts(user)
	
	 if user && user.authenticate(params[:session][:password])
	 	session[:user_id] = user.id

	 	flash[:success] = "You have successfully logged in"
	 	  
	 	redirect_to root_path

	else
		flash[:error] = "There was something wrong with your login information"
		# binding pry
		redirect_to '/login'
	end

end

def destroy
	session[:user_id] = nil 
	flash[:success] = "You have successfully logged out"
	redirect_to login_path
end


private 

def logged_in_redirect

if logged_in?
	flash[:error] = "You have already logged in"
	redirect_to root_path
end	
end


def user_params
  params.require(:user).permit(:username, :password)
end

end

