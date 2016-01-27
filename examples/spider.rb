require "mechanize"
require "pry"

class Spider
  REQUEST_INTERVAL = 1
  MAX_URLS = 1000

  attr_reader :handlers

  def initialize(processor, options = {})
    @processor = processor

    @results  = []
    @urls     = []
    @handlers = {}

    @interval = options.fetch(:interval, REQUEST_INTERVAL)
    @max_urls = options.fetch(:max_urls, MAX_URLS)

    enqueue(@processor.root, @processor.handler)
  end

  def enqueue(url, method, data = {})
    return if @handlers[url]
    @urls << url
    @handlers[url] ||= { method: method, data: data }
  end

  def record(data = {})
    @results << data
  end

  def results
    return enum_for(:results) unless block_given?

    i = @results.length
    enqueued_urls.each do |url, handler|
      begin
        log "Handling", url.inspect
        @processor.send(handler[:method], agent.get(url), handler[:data])
        if block_given? && @results.length > i
          yield @results.last
          i += 1
        end
      rescue => ex
        log "Error", "#{url.inspect}, #{ex}"
      end
      sleep @interval if @interval > 0
    end
  end

  private

  def enqueued_urls
    Enumerator.new do |y|
      index = 0
      while index < @urls.count && index <= @max_urls
        url = @urls[index]
        index += 1
        next unless url
        y.yield url, @handlers[url]
      end
    end
  end

  def log(label, info)
    # warn "%-10s: %s" % [label, info]
  end

  def agent
    @agent ||= Mechanize.new
  end
end

class ProgrammableWeb
  attr_reader :root, :handler

  def initialize(root: "https://programmableweb.com/apis/directory", handler: :process_index)
    @root = root
    @handler = handler
  end

  def process_index(page, data = {})
    page.links_with(href: /\?page=\d+/).each do |link|
      spider.enqueue(link.href, :process_index)
    end

    page.links_with(href: %r{/api/\w+$}).each do |link|
      spider.enqueue(link.href, :process_api, name: link.text)
    end
  end

  def process_api(page, data = {})
    categories = page.search("article.node-api .tags").first.text.strip.split(/\s+/)
    fields = page.search("#tabs-content .field").each_with_object({}) do |tag, results|
      key = tag.search("label").text.strip.downcase.gsub(/[^\w]+/, ' ').gsub(/\s+/, "_").to_sym
      val = tag.search("span").text
      results[key] = val
    end

    spider.record data.merge(fields).merge(categories: categories)
  end

  def results(&block)
    spider.results(&block)
  end

  private

  def spider
    @spider ||= Spider.new(self)
  end
end

if __FILE__ == $0
  spider = ProgrammableWeb.new

  spider.results.lazy.take(5).each_with_index do |result, i|
    warn "%-2s: %s" % [i, result.inspect]
  end
end
