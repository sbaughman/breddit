class TagsController < ApplicationController

  def show
    @tag = Tag.find_by(name: params[:id])
    @links = @tag.links.order(karma: :desc).page(params[:page])
  end

end
