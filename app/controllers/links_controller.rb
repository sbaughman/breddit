class LinksController < ApplicationController

  def index
    @links = Link.order(votes: :desc).page(params[:page])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to :root
    else
      if @link.errors[:url] && !@link.url.nil?
        vote_link = Link.where("url = ?", @link.url).first
        vote_link.increment!(:votes)
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def upvote
    @link = Link.find(params[:id])
    @link.increment!(:votes)
    redirect_to root_path(page: params[:page])
  end

  def downvote
    @link = Link.find(params[:id])
    @link.decrement!(:votes)
    redirect_to root_path(page: params[:page])
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :summary, :user_id)
  end

end
