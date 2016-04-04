class SessionsController < ApplicationController
  before_action :disallow_user, only: [:create, :new]

  def new
  end

  def create
    if @user = User.find_by_username(params[:session][:username]).try(:authenticate, params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "#{@user.username} successfully logged in"
      redirect_to :root
    else
      flash[:danger] = "Not a valid username and/or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to :root
  end

end
