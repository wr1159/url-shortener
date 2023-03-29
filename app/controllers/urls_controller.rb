# frozen_string_literal: true

# Controller for managing URL shortening
class UrlsController < ApplicationController
  # GET /urls/#short
  def show
    @url = Url.find_by(short: params[:id]) 
  end

  def redirect
    @url = Url.find_by(short: params[:short])
    redirect_to @url.target, allow_other_host: true
  end

  # GET /urls/new
  def new
    @urls = Url.all
    @url = Url.new
  end

  # POST /urls
  def create
    @url = Url.new(url_params)
    @url.short = generate_short_url

    if @url.save
      redirect_to @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def url_params
    params.require(:url).permit(:target, :title, :short)
  end

  # Generate a random string of 7 characters
  # If the string already exists in the database, generate a new one
  def generate_short_url
    loop do
      short_url = 7.times.map { [*'a'..'z', *'A'..'Z', *'0'..'9'].sample }.join
      return short_url unless Url.exists?(short: short_url)
    end
  end
end
