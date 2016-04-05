class CommentsController < ApplicationController
  before_action :require_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to :back
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :link_id)
  end

end
