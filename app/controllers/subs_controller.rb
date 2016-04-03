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
      redirect_to subs_path
    else
      render :new
    end
  end

  def show
    @sub = params[:id] ? Sub.find(params[:id]) : Sub.find_by(name: params[:name])
    unless @sub.nil?
      @links = Link.where("sub_id = ?", @sub.id).order(karma: :desc).page(params[:page])
    else
      redirect_to root_path
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:name, :description)
  end

end
