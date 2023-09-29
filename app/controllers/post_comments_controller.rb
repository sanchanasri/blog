class PostCommentsController < ApplicationController
  before_action :set_topic_and_post
  def new
  end
  def create
    @comment=@post.post_comments.build(comment_params)
    @comment.user= current_user
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

  def edit
  @comment=@post.post_comments.find(params[:id])
  end

  def update
    #@post=Post.find(params[:post_id])
    @comment=@post.post_comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end


  # comments_controller.rb

  def destroy
    @comment = PostComment.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Failed to delete the comment.'
    end

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
      @post=Post.find(params[:post_id])

    end
    end

end
