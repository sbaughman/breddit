class CommentsController < ApplicationController
  before_action :require_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.link_id = params[:link_id]
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to :back
    else
      @link = Link.find(params[:link_id])
      render template: 'links/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :link_id)
  end

end
