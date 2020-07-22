
require 'twilio-ruby'
require 'twitter'

account_sid = 'ACa20c5d7e62f2ec1fc24c1654ec49d734'
auth_token = '6027500ef80d04c639ee977ffc5b3ec7'
client2 = Twilio::REST::Client.new(account_sid, auth_token)

twilio_phone = '+17074162793' # Your Twilio number
#phone = '+17329120333' # Your mobile phone number

client = Twitter::REST::Client.new do |config|
  config.consumer_key = "f1ZMYvYz5EKom8gZjindRSyie"
  config.consumer_secret = "GVhYbE45ZfTnJAEJHXhRIIInvlK6IQo3r4F75PgjHQDPyQVAyM"
  config.access_token = "1191487449337344000-KnDencLTtNpIXZpR6cVH1olaLypnmX"
  config.access_token_secret = "FFfx6WxuaSVeJMV3IW2rHtfRnyLp8NUU4xR4OAELCXBnv"
end

tweeting = ""

puts "Please enter a keyword: "
keyword = gets.chomp
puts "Here are the results for #{keyword}:"

client.search(keyword, result_type: "recent", lang: "en").take(5).collect do |tweet|

  puts "-> #{tweet.user.screen_name} tweeted '#{tweet.full_text}'\n\n"
  tweeting = "-> #{tweet.user.screen_name} tweeted '#{tweet.text}'\n\n"

end

puts "Would you like to send a the tweets via SMS?:"
choice = gets.chomp

if choice == "Y" || choice == "y"
  puts "Please enter a cellphone number: "
  num = gets.chomp
  phone = '+1' + "#{num}"

  client2.messages.create(
  from: twilio_phone,
  to: phone,
  body: "Here is your first tweet search results:\n#{tweeting}"
  )
else
  puts "Thank You!"
end
