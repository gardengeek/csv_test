class ApplicationController < ActionController::Base
  include ::SslRequirement
  protect_from_forgery

  private

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

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
end
