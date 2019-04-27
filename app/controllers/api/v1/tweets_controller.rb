class Api::V1::TweetsController < ApplicationController

  def create
    tweet = Tweet.new(content: params[:content], feed_id: 5)
    if tweet.save
      # Broadcast the fact that this happened out to all the subscribers
      ActionCable.server.broadcast("feed_channel", tweet)
      render json: tweet
    else
      render json: {error: 'Could not create that tweet'}, status: 422
    end
  end
  
end
