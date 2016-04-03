class LinksController < ApplicationController

  def index
    @links = Link.order(karma: :desc).page(params[:page])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:success] = "Link successfully created!"
      redirect_to :root
    else
      if @link.errors[:url] && !@link.url.nil?
        vote_link = Link.find_by("url = ?", @link.url)
        Vote.create!(link_id: vote_link.id, value: 1)
        flash[:info] = "Link to that URL already exists"
        redirect_to root_path
      else
        render :new
      end
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :summary, :user_id, :sub_id)
  end

end
