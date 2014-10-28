class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @comments = Comment.all
    render json: @comments.as_json
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def comment_params
    params.require(:comment).permit(:title, :text)
  end

end
