class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :category]
  before_action :set_tweet, only: [:show, :destroy, :edit, :update]

  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path unless current_user.id == @tweet.user.id
  end

  def update
    @tweet.update(tweet_params)
    if @tweet.valid?
      redirect_to tweet_path
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @tweet.user.id
      @tweet.destroy
      redirect_to root_path
    end
  end

  def category
    @tweet = Tweet.find_by(category_id: params[:id])
    @tweets = Tweet.where(category_id: params[:id]).order('created_at DESC')
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :article, :category_id, :prefecture_id, :city, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
