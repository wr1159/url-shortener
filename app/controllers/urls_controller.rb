# frozen_string_literal: true

require 'geocoder'
# Controller for managing URL shortening
class UrlsController < ApplicationController
  # GET /urls/#short
  def show
    @url = Url.find_by(short: params[:id]) 
  end

  def redirect
    @url = Url.find_by(short: params[:short])
    @url.count += 1
    @url.save
    country = request.location.country
    city = request.location.city
    # country = 'Unknown' if country.nil?
    # city = 'Unknown' if city.nil?

    # # Create a new UrlVisit object with the country and city @url.url_visits.create(country: country, city: city)
    @url.url_visits.create(country: country, city: city)

    redirect_to @url.target, allow_other_host: true
  end

  # GET /urls/new
  def new
    @urls = Url.all
    @url = Url.new
  end

  # POST /urls
  def create
    @urls = Url.all
    @url = Url.new(url_params)
    @url.short = generate_short_url

    if @url.save
      redirect_to @url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def url_params
    params.require(:url).permit(:target, :title, :short, :count)
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
