# trello.rb
require "http"
require "addressable/uri"

def app_key
  ENV.fetch("TRELLO_APP_KEY")
end

def app_token
  ENV.fetch("TRELLO_APP_TOKEN")
end

def trello_url(path, params = {})
  auth_params = { key: app_key, token: app_token }

  Addressable::URI.new({
    scheme: "https",
    host: "api.trello.com",
    path: File.join("1", path),
    query_values: auth_params.merge(params)
  })
end

def get(path)
  HTTP.get(trello_url(path)).parse
end

puts get("members/me/actions")
