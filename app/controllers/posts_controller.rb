class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_topic
  # GET /posts or /posts.json
  def index
    @posts = @topic.posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post=@topic.posts.find(params[:id])
  end

  # GET /posts/new
  def new
    @topics = Topic.find(params[:topic_id])
    @post = @topics.posts.build
  end

  # GET /posts/1/edit
  def edit
    @post=@topic.posts.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params)

    if @post.save
      redirect_to topic_post_path(@topic,@post)
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to topic_post_path(@topic,@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post= @subject.posts.find(params[:id])

    if @post.destroy
      flash[:notice]="Successfully deleted"
      redirect_to topic_path(@topic)
    else
      flash[:alert] = 'Unable to delete the story.'
      redirect_to topic_post_path(@topic, @post)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :description, :topic_id)
    end

  def set_topic
    @topic= Topic.find(params[:topic_id])
  end
end
