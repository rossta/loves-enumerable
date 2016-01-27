require "set"

class Spider
  REQUEST_INTERVAL = 1
  MAX_URLS = 1000

  attr_reader :handlers

  def initialize(root, method, attrs = {})
    @urls     = Set.new
    @handlers = {}
    @results  = []

    @interval = attrs.fetch(:interval, REQUEST_INTERVAL)
    @max_urls = attrs.fetch(:max_urls, MAX_URLS)

    enqueue(root, method)
  end

  def enqueue(url, method)
    return if @handlers[url]
    @urls << url
    @handlers[url] ||= { method: method, data: {} }
  end
end

if __FILE__ == $0
  spider = Spider.new("https://programmableweb.com/apis/directory", :process_index)

  puts spider.handlers.inspect
end
