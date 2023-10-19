
class PostsController < ApplicationController
  before_action :set_post_and_topic, only: %i[ show edit update destroy remove_image mark_as_read]

  # GET /posts or /posts.json

  def mark_as_read
    if current_user.posts << @post
      render json: { status: :success }
    else
      render json: { status: :error, error: 'Failed to mark post as read' }, status: :unprocessable_entity
    end
  end

  def index
    if params[:from_date].blank? && params[:to_date].blank?
      from_date=1.day.ago.to_date
      to_date=Date.today
    else
      from_date=params[:from_date]
      to_date=params[:to_date]
    end
    unless params[:topic_id]
    if from_date.present?
      @posts=Post.includes(:topic).created_between(from_date,to_date)
    else
      @posts = Post.includes(:topic).where('created_at <= ?', to_date)
    end
    @pagy, @posts = pagy(@posts.all, items: 10)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment_rating= UserCommentRating.new
    @comments= @post.post_comments.includes(:user)
  end


  def remove_image
    @post.image.purge
    redirect_to @post, notice: 'Image removed successfully.'
  end


  # GET /posts/new
  def new
    @topic=Topic.find(params[:topic_id])
    @post=@topic.posts.new
    respond_to do |format|
      format.js
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    if params[:topic_id]
      @topic=Topic.find(params[:topic_id])
      @post = @topic.posts.build(post_params)
    else
      @post=Post.new(post_params)
    end
    @post.user= current_user

    if @post.save
      new_tag_name
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      new_tag_name
      redirect_to topic_post_path(@post.topic_id,@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.destroy
      redirect_to topic_path(@topic)
    else
      redirect_to topic_post_path(@topic, @post)
    end
  end

  private
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
    params.require(:post).permit(:name, :description, :topic_id,:image, tag_ids: [])
  end
  
  def new_tag_name
    if params.dig(:post, :new_tag_name).present?
      tag= Tag.find_or_create_by(name: params[:post][:new_tag_name])
      @post.tags << tag
    end
  end
end
