class UserCommentRatingsController < ApplicationController
  before_action :set_topic_and_post
  def index

  end

  def new
    @comment_rating=UserCommentRating.new
  end
  def create
    @comment_rating=@comment.user_comment_ratings.build(c_ratings_params)
    @comment_rating.user=current_user
    @comment_rating.post_comment=@comment
    if @comment_rating.save
      redirect_to @post, notice: 'ratings saved'
    else
      render 'new'
    end
  end

  private

  def c_ratings_params
    params.require(:user_comment_rating).permit(:CommentRating)
  end
  def set_topic_and_post
    if params[:topic_id]
     @topic=Topic.find(params[:topic_id])
     @post=@topic.posts.find(params[:post_id])
     @comment=@post.post_comments.find(params[:post_comment_id])
    else
      @post=Post.find(params[:post_id])
      @comment=@post.find(params[:post_comment_id])
      end
  end
end
