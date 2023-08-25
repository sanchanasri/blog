class WelcomeController < ApplicationController
  def index
    @article=Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @welcome= Article.new
  end
  def create
    @welcome=Article.new(title:"...",body:"...")
    if @welcome.save
      redirect_to @welcome
    else
      render :new, status: :unprocessable_entity
    end
    private
    def welcome_params
      params.require(:welcome).permit(:title, :body)
    end
  end
  end

