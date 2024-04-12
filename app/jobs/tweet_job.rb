class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.published?

    # Rescheduled a tweet to the future
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end

# Push the publish_at to past
# noon -> 8am
# -
# 8am -> publish the tweet and set the tweet_id
# noon -> published, does nothing

# Push the publish_at to future
# 8am -> 1pm
# -
# 8am -> checks publish_at and does nothing
# 1pm -> should publish the tweet and set the tweet_id
