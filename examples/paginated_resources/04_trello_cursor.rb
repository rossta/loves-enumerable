require "http"
require "addressable/uri"
require "pry"

class Client
  def initialize(opts = {})
    @app_key   = opts.fetch(:app_key, ENV.fetch("TRELLO_APP_KEY"))
    @app_token = opts.fetch(:app_token, ENV.fetch("TRELLO_APP_TOKEN"))
  end

  def get(path, params = {})
    HTTP.get(trello_url(path, params)).parse
  end

  private

  def trello_url(path, params = {})
    auth_params = { key: @app_key, token: @app_token }

    Addressable::URI.new({
      scheme: "https",
      host: "api.trello.com",
      path: File.join("1", path),
      query_values: auth_params.merge(params)
    })
  end
end

class Cursor
  include Enumerable

  def initialize(path, params = {})
    @path       = path
    @params     = params

    @collection = []
    @before     = params.fetch(:before, nil)
    @limit      = params.fetch(:limit, 50)
  end

  def each(start = 0)
    return to_enum(:each, start) unless block_given?

    Array(@collection[start..-1]).each do |element|
      yield(element)
    end

    unless last?
      start = [@collection.size, start].max

      fetch_next_page

      each(start, &Proc.new)
    end
  end

  private

  def client
    @client ||= Client.new
  end

  def fetch_next_page
    response              = client.get(@path, @params.merge(before: @before, limit: @limit))
    @last_response_empty  = response.empty?
    @collection           += response
    @before               = response.last["id"] unless last?
  end

  MAX = 1000

  def last?
    @last_response_empty || @collection.size >= MAX
  end
end

def paginated_get(path, params = {})
  Cursor.new(path, params)
end

def comments
  paginated_get("members/me/actions", filter: "commentCard")
end

if __FILE__ == $0
  puts "Requesting 10 comments..."
  puts
  puts comments.lazy.
     map { |axn| axn["data"]["text"] }.
     select { |txt| txt.start_with?("@mgerrior") }.
     take(10).force
end
