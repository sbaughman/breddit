class SubsController < ApplicationController

  def index
    @subs = Sub.all.page(params[:page])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      flash[:success] = "Sub-breddit created!"
      redirect_to subs_path
    else
      render :new
    end
  end

  def show
    @sub = params[:id] ? Sub.find(params[:id]) : Sub.find_by(name: params[:name])
    if @sub.nil?
      flash[:danger] = "Not a valid sub-breddit name"
      redirect_to root_path    
    else
      @links = @sub.links.order(karma: :desc).page(params[:page])
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:name, :description)
  end

end
