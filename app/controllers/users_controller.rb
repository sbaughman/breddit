class UsersController < ApplicationController
  before_action :disallow_user, only: [:new, :create]

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
      @submitted_links = Link.where("user_id = ?", @user.id).order(karma: :desc).page(params[:page]).per(5)
      @user_votes = Vote.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(5)
      @voted_links = @user_votes.map { |vote| Link.find(vote.link_id) }
      @user_clicks = Click.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(5)
      @clicked_links = @user_clicks.map { |click| Link.find(click.link_id) }
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
    if @user.authenticate(params[:user][:old_password])
      @user.update(password: params[:user][:password])
      flash[:success] = "Profile successfully updated"
      redirect_to user_name_path(@user.username)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :bio, :password)
  end

end
