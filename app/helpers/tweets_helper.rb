module TweetsHelper
  def get_tagged(tweet)
    message_words = tweet.message.split

    message_words.each_with_index do |word, index|
      if word[0] == '#'
        # i found a tag!
        tag = Tag.find_or_create_by(phrase: word.downcase)
        tweet_tag = TweetTag.create(tweet_id: @tweet.id, tag_id: tag.id)
        message_words[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    tweet.update(message: message_words.join(" "))
  end
end
