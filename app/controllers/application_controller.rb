require "twitter"
require "twit_init"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def twit_init
    @twit_init || TwitInit.new
  end
end
