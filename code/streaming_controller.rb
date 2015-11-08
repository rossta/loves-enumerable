class StreamingController < ApplicationController
  def index
    @articles = Article.most_recent
    render stream: true
  end
end
