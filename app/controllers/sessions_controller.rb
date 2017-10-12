class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  def new
   	#only render the login form
    respond_to do |format|
      format.html { render  :layout => false  } 
    end 
  end

  def create
   	user = User.find_by(account: params[:user][:account])
   	password = params[:user][:password]
   	if user && user.authenticate(password)
   	 	session[:user_id] = user.id
   	 	redirect_to root_path, notice: "Logged in OK"   	 	
   	else
   	 	redirect_to login_path, alert: "Invalida combinacion de username/password"
   	end
  end

  def destroy
   	# only active when logout
    reset_session
    redirect_to login_path, notice: "You have been log out"
  end
end
