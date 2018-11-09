# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[update destroy]
  before_action :authenticate_user, only: %i[update destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    flash.now[:notice] = 'Comment was created successfully.' if @comment.save
  end

  def update
    @comment.update(comment_params)
    respond_with_bip(@comment)
  end

  def destroy
    flash[:notice] = 'Comment was deleted successfully.' if @comment.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_commentable
    @commentable = Project.find(params[:project_id])
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authenticate_user
    return if @comment.user_id == current_user.id

    redirect_to root_path, error: 'Invalid Access'
  end
end
