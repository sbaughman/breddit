class LinksController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @links = Link.order(karma: :desc).page(params[:page])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user
    if @link.save
      flash[:success] = "Link successfully created!"
      redirect_to :root
    else
      if @link.errors[:url] && !@link.url.nil?
        vote_link = Link.find_by("url = ?", @link.url)
        vote_link.votes.create(value: 5, user_id: current_user.id)
        flash[:info] = "Link to that URL already exists"
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      flash[:success] = "Link updated!"
      redirect_to @link
    else
      render :edit
    end
  end

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new
  end

  def click
    @link = Link.find(params[:id])
    if current_user
      @link.clicks.create(value: 1, user_id: current_user.id)
    else
      @link.clicks.create(value: 1)
    end
    redirect_to @link.url
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :summary, :sub_id, :tag_list)
  end

end
