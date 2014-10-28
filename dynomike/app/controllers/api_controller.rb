class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @comments = Comment.all
    render json: @comments.as_json
  end

  def create
    begin
      @comment = Comment.new(comment_params)
      if @comment.save
        render :nothing => true, :status => 200
      else
        render :nothing => true, status: :unprocessable_entity
      end

    rescue Exception
      render :nothing => true, status: :bad_request
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :text)
  end

end
