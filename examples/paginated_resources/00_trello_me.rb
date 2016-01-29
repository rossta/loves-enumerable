# trello.rb
require "http"

def app_key
  ENV.fetch("TRELLO_APP_KEY")
end

def app_token
  ENV.fetch("TRELLO_APP_TOKEN")
end

url = "https://api.trello.com/1/members/me?key=#{app_key}&token=#{app_token}"
puts HTTP.get(url).parse
