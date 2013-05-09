require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = ''
  config.consumer_secret    = ''
  config.oauth_token        = ''
  config.oauth_token_secret = ''
  config.auth_method        = :oauth
end

keyword = "keyword"
action = 'open -a "Google Chrome" "http://google.com"'
from_user = "frankie"

client = TweetStream::Client.new

client.userstream do |status|
  text = status.text
  puts "[#{status.user.screen_name}] #{text}"
  if from_user.eql?status.user.screen_name
    system(action)
  end

  #find the text hat followed the keyword
  match_string = "/#{keyword}\s(.*)/"
  text = text.match(match_string)[1]
  unless text.nil?
    IO.popen('pbcopy', 'w').puts text
  end

end
