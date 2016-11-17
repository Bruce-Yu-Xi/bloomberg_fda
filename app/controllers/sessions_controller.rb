class SessionsController < ApplicationController
  def create
    user = User.find_by_username(params[:username])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:username, :password)
    end
end
