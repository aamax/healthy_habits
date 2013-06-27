class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def admin_user?
    !current_user.nil? && (current_user.has_role? :admin)
  end

  def report_name
    '5 Secrets to a Healthier Sexier Body'
  end

end
