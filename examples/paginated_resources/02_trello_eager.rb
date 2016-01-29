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

def get(path, params = {})
  HTTP.get(trello_url(path, params)).parse
end

def paginated_get(path, options = {})
  params  = options.dup
  before  = nil
  max     = params.delete(:max) { 1000 }
  limit   = params.delete(:limit) { 50 }
  results = []

  loop do
    data = get(path, { before: before, limit: limit }.merge(params))

    results += data

    break if (data.empty? || results.length >= max)

    before = data.last["id"]
  end

  results
end

def comments(params = {})
  paginated_get("members/me/actions", params.merge(filter: "commentCard"))
end

if __FILE__ == $0
  puts "Requesting comments..."
  puts
  puts comments
end
