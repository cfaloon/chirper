class EpicenterController < ApplicationController
  before_action :authenticate_user!

  def feed
    @following_tweets = []
    Tweet.all.order(created_at: :desc).each do |tweet|
      if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
        @following_tweets.push(tweet)
      end
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
    @tweets = @tag.tweets.order(created_at: :desc)
  end

  def all_users
    @users = User.all
  end

  def following
    @users = User.where(id: current_user.following)
  end

  def followers
    @users = []

    User.all.each do |user|
      if user.id != current_user.id && user.following.include?(current_user.id)
        @users << user
      end
    end
  end
end
