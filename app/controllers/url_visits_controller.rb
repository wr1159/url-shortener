# frozen_string_literal: true

# Controller for Url Visits
class UrlVisitsController < ApplicationController
  def create
    url = Url.find_by(short: params[:short])
    url_visit = url.url_visits.new(url_visit_params)
    if url_visit.save
      # do something if successful, e.g. redirect
    else
      render :new, status: :unprocessable_entity
      # do something if unsuccessful, e.g. render an error message
    end
  end

  private

  def url_visit_params
    params.require(:url_visit).permit(:country, :city)
  end
end
