class PostsController < ApplicationController
  before_action :set_post_and_topic, only: %i[ show new edit update destroy ]
  before_action :set_topic, only: %i[index]
  # GET /posts or /posts.json
  def index
    if params[:topic_id]
       @posts = @topic.posts
    else
      @posts=Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
      @comments= @post.post_comments
  end

  # GET /posts/new
  def new
      @post=Post.new
  end

  # GET /posts/1/edit
  def edit

  end

  # POST /posts or /posts.json
  def create
    if params[:topic_id]
      @topic=Topic.find(params[:topic_id])
      @post = @topic.posts.new(post_params)
      @post.topic=@topic
    else
      @post=Post.new(post_params)
    end
    if params[:post][:new_tag_name].present?
      tag_names = params[:post][:new_tag_name].split(',')
      tag_names.each do|tag_name|
      tag=Tag.find_or_create_by(name: tag_name.strip)
      @post.tags << tag
      end
    end
    if @post.save
      @post.tags << Tag.where(id: params[:post][:tag_ids])
      redirect_to topic_post_path(@post.topic_id,@post)
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post.tags = Tag.where(id: params[:post][:tag_ids])
    if @post.update(post_params)
      redirect_to topic_post_path(@post.topic_id,@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
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
    def set_post_and_topic
      if params[:topic_id]
      @topic=Topic.find(params[:topic_id])
      @post = @topic.posts.find(params[:id])
      else
        @post=Post.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :description, :topic_id, :tag_id)
    end

  def set_topic
    @topic= Topic.find(params[:topic_id])
  end
end
