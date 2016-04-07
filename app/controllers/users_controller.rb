class UsersController < ApplicationController
  before_action :disallow_user, only: [:new, :create]
  before_action :require_user, only: [:update, :edit, :password_edit]

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
      @submitted_links = @user.links.order(karma: :desc).page(params[:page]).per(5)
      @voted_links = @user.voted_links.order(created_at: :desc).page(params[:page]).per(5)
      @clicked_links = @user.clicked_links.order(created_at: :desc).page(params[:page]).per(5)
    else
      flash[:danger] = "Not a valid user"
      redirect_to users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:old_password] && @user.authenticate(params[:user][:old_password])
      @user.update(password: params[:user][:password])
      flash[:success] = "Password successfully updated"
      redirect_to user_name_path(@user.username)
    else
      if @user.update_attributes(user_params)
        flash[:success] = "Profile successfully updated"
        redirect_to user_name_path(@user.username)
      else
        render :edit
      end
    end
  end

  def password_edit
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :bio, :password)
  end

end
