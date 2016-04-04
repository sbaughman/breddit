class UsersController < ApplicationController

  def index
    @users = User.order(karma: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created!"
      redirect_to user_name_path(@user.username)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(username: params[:username])
    unless @user.nil?
      @links = Link.where("user_id = ?", @user.id).order(karma: :desc).page(params[:page])
    else
      flash[:danger] = "Not a valid user"
      redirect_to users_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :bio, :password)
  end

end
