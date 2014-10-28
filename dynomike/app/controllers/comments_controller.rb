class CommentsController < ApplicationController

  http_basic_authenticate_with name: ENV["dynomike_username"], password: ENV["dynomike_password"]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to comments_path
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to comments_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to comments_path
  end

  def delete_all
    @comments = Comment.all
    @comments.each do |comment|
      comment.destroy
    end

    redirect_to comments_path
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :text)
  end

end
