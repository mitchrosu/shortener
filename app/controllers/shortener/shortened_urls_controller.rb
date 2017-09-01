require 'voight_kampff'

class Shortener::ShortenedUrlsController < ActionController::Base
  include Shortener

  def show
  	safe_params = params.to_unsafe_h
    token = ::Shortener::ShortenedUrl.extract_token(safe_params[:id])
    track = Shortener.ignore_robots.blank? || request.human?
    url   = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: safe_params, track: track)
    redirect_to url[:url], status: :moved_permanently
  end
end
