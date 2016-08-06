class SessionsController < ApplicationController


  def new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["User with those credentials not found"]
      render :new
    else
      login!(user)
      redirect_to subs_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
