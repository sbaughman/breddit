class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @links = @tag.links.page(params[:page])
  end

end
