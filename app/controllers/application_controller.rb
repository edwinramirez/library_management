class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  private
  def permission_denied
    flash[:error] = "You don't have the proper permissions to view this page."
    redirect_to(request.referrer || root_path)
  end
end
