class PostCommentsController < ApplicationController
  before_action :set_topic_and_post,only: %i[ show new create ]
  def new
  end
  def create
    @comment=PostComment.new(comment_params)
    @comment.post=@post
    if @comment.save
      flash[:success] = 'Comment posted successfully'
    else
      flash[:error] = 'Failed to post comment'
    end
    redirect_to topic_post_path(@topic, @post)
  end

  def show
    @comments=@post.post_comments
  end
  private
  def comment_params
    params.require(:post_comment).permit(:name ,:description)
  end


  def set_topic_and_post
    if params[:topic_id]
      @topic=Topic.find(params[:topic_id])
      @post=@topic.posts.find(params[:post_id])
    else
      @post=Post.find(params[:id])

    end
    end

end
