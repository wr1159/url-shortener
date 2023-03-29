class UrlsController < ApplicationController
  def create
    @urls = Url.all
  end
end
