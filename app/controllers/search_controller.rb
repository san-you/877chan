class SearchController < ApplicationController

  def index
    # TODO: 多分もっといい書き方ある
    if params["query"].blank?
      @search_results = []
    else
      @query = params["query"]
      @search_results = SearchResult.make_result(params["query"])
    end
  end
end