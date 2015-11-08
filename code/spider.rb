require 'mechanize'
require 'pry'

class Spider
  REQUEST_INTERVAL = 5
  MAX_URLS = 100

  def initialize(url, handler, attrs = {})
    @urls     = []
    @handlers = {}
    @results  = []

    @interval = attrs.fetch(:interval, REQUEST_INTERVAL)
    @max_urls = attrs.fetch(:max_urls, MAX_URLS)

    @urls << url
    @handlers[url] = [handler, {}]
  end

  def results
    return enum_for(:results) unless block_given?

    i = @results.length
    url_enum.each do |url, handler, data|
      begin
        log "Handling", url.inspect
        send handler, agent.get(url), data
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

  def process(url, handler, data = {})
    return if @handlers[url]

    @urls << url
    @handlers[url] = [handler, data]
  end

  protected

  def url_enum
    index = 0
    Enumerator.new do |y|
      while index < @urls.count && index <= @max_urls
        url = @urls[index]
        next unless url
        handler, data = @handlers[url]
        y.yield url, handler, data
        index += 1
      end
    end
  end

  def record(data = {})
    log "Record", pp(data)
    @results << data
  end

  def agent
    @agent ||= Mechanize.new
  end

  def resolve_url(href, page)
    agent.agent.resolve(href, page).to_s
  end

  def log(label, info)
    warn "%-10s: %s" % [label, info]
  end
end

class GutenbergSpider < Spider
  def process_index(page, data = {})
    links = page.links_with(href: %r{^/ebooks/\d+$})

    links.map do |a|
      title, author = a.text.strip.split("\n")
      process resolve_url(a.href, page), :process_book,
        title: title,
        author: author,
        index: a.href
    end
  end

  def process_book(page, data)
    urls = %w[epub kindle txt htm].each_with_object({}) do |fmt, hash|
      hash[fmt] = page.links_with(href: %r{ebooks/[^/]*#{fmt}.*$}).map(&:href)
    end
    record data.merge(urls)
  end
end

if __FILE__ == $0
  require 'yaml/store'
  path   = File.expand_path("../../data/ebooks.store", __FILE__)
  store  = YAML::Store.new(path)

  # Get links for top 5 Charles Dickens ebooks
  spider = GutenbergSpider.new('http://www.gutenberg.org/ebooks/author/37', :process_index)

  spider.results.lazy.take(5).each_with_index do |result, i|
    puts "storing #{i}: #{result.inspect}"

    store.transaction do
      store[result[:title]] = result
      store.commit
    end
  end

  puts File.read(path)
end
