class LinksController < ApplicationController

  def index
    @links = Link.order(votes: :desc)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to :root
    else
      render :new
    end
  end

  def vote
    @link = Link.find(params[:id])
    @link.increment!(:votes)
    redirect_to @link.url
  end

  def show
    @link = Link.find(params[:id])
    redirect_to @link.url
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :summary)
  end

end
