#!/usr/bin/env rackup -s puma

class App
  def call(env)
    [200, {'Content-Type' => 'text/plain', 'Cache-Control' => 'no-cache'}, self]
  end

  def each
    yield 'one'
    sleep 1
    yield 'two'
    sleep 2
    yield 'three'
    sleep 3
  end
end

use Rack::Chunked
run App.new

# from https://gist.github.com/raggi/60962b3d4325ccc41a91

# curl --raw -i http://localhost:9292 to see results

# one
# 3
# two
# 5
# three
# 0
