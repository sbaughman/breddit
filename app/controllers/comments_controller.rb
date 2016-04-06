class CommentsController < ApplicationController
  before_action :require_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to :back
    else
      @link = Link.find(params[:comment][:link_id])
      render template: 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :link_id)
  end

end
