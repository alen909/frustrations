class CommentsController < ApplicationController

  before_filter :check_ownership, only: [:destroy, :update]

  def create
    frustration = Frustration.find(params[:frustration_id])
    @comment = frustration.comments.build(comment_params)
    @comment.user= current_user if current_user
    @comment.save

    respond_to do |format|
      format.html do
        redirect_to frustration
      end
      
      format.js do
        render
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.frustration
  end

  private
  def check_ownership
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id
      redirect_to frustrations_url,
      alert: "You can only delete own comments"
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
