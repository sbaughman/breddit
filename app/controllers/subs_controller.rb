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
    @sub = Sub.find(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:name, :description)
  end

end
