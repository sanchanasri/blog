class RatingsController < ApplicationController


  def new
    if params[:topic_id]
      @topic=Topic.find(params[:topic_id])
      @post=@topic.posts.find(params[:post_id])
    else
      @post=Post.find(params[:post_id])
    end
    @rating=@post.ratings.new

  end

  def create
    if params[:topic_id]
      @topic=Topic.find(params[:topic_id])
      @post=@topic.posts.find(params[:post_id])
    else
      @post=Post.find(params[:post_id])
    end
    @rating=@post.ratings.build(rating_params)
    if @rating.save
      redirect_to @post, notice: "thanks for rating"
    else
      render :new
    end
  end
  private
  def rating_params
    params.require(:rating).permit(:value)
  end
end
