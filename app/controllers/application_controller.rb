class ApplicationController < ActionController::Base
  include Clearance::Authentication
  include ::SslRequirement
  protect_from_forgery

  private

  def authorize
    if signed_in?
      Time.zone = current_user.time_zone
    else
      deny_access "You must be signed in to access this page"
    end
  end

  def signed_in?
    current_user && current_user.active? && current_user.confirmed?
  end

  def require_no_user
    if signed_in?
      flash.keep
      redirect_to account_url
      return false
    end
  end
  
  def ssl_required?
    return super if Rails.env.production?
    false
  end
end
