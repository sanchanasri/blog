class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post_and_topic, only: %i[ show edit update destroy remove_image]

  # GET /posts or /posts.json
  def index
    if params[:topic_id]
      @pagy,@posts = pagy(@topic.posts, items:10)
    else
      @pagy, @posts=pagy(Post.includes(:topic).all, items:10)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
      @comments= @post.post_comments
  end


  def remove_image
    @post.image.purge
    redirect_to @post, notice: 'Image removed successfully.'
  end


  # GET /posts/new
  def new
    @topic=Topic.find(params[:topic_id])
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
    @post.user= current_user
    if @post.save
      @post.tags << Tag.where(id: params[:post][:tag_ids])
      @post.image.attach(params[:post][:image])

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
      params.require(:post).permit(:name, :description, :topic_id, :image,:other_attributes)
    end

  def set_topic
    @topic= Topic.find(params[:topic_id])
  end
end
