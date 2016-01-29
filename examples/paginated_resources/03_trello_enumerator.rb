require "http"
require "addressable/uri"
require "pry"

MAX = 1000

def app_key
  ENV.fetch("TRELLO_APP_KEY")
end

def app_token
  ENV.fetch("TRELLO_APP_TOKEN")
end

def auth_params
  { key: app_key, token: app_token }
end

def trello_url(path, params = {})
  Addressable::URI.new({
    scheme: "https",
    host: "api.trello.com",
    path: File.join("1", path),
    query_values: auth_params.merge(params)
  })
end

def paginated_get(path, options = {})
  Enumerator.new do |y|
    params  = options.dup
    before  = nil
    total   = 0
    limit   = params.delete(:limit) { 50 }

    loop do
      data = get(path, { before: before, limit: limit }.merge(params))
      total += data.length

      data.each do |element|
        y.yield element
      end

      break if (data.empty? || total >= MAX)

      before = data.last["id"]
    end
  end
end

def get(path, params = {})
  HTTP.get(trello_url(path, params)).parse
end

def comments(params = {})
  paginated_get("members/me/actions", params.merge(filter: "commentCard"))
end

if __FILE__ == $0
  puts "Requesting 10 comments..."
  puts
  puts comments(limit: 5).lazy.
    map { |axn| axn["data"]["text"] }.
    select { |txt| txt.start_with?("@mgerrior") }.
    take(10).force
end
