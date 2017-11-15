class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    login_params = session_params

    log_in(login_params[:username], login_params[:password])

    if !user_logged_in?
      flash.now[:alert] = 'Invalid username/password combination'

      render 'new'
    end
  end

  def destroy
    log_out
  end

  private

    def session_params
      params.require(:sessions).permit(:username, :password)
    end
end
