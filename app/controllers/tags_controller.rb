class TagsController < ApplicationController
  before_action :set_topic_post
  before_action :set_tag, only: [:show, :edit, :update,]

  def index
    @tags = @post.tags
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Tag created'
      redirect_to topic_post_tags_path(@topic, @post)
    else
      flash[:error] = 'Failed to create tag'
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:success] = 'Tag updated'
      redirect_to topic_post_tags_path(@topic, @post)
    else
      flash[:error] = 'Failed to update tag'
      render :edit
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_topic_post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
