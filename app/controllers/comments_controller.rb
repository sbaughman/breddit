class CommentsController < ApplicationController
  before_action :require_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.link_id = params[:id]
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to link_path(params[:id])
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
