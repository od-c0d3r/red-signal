class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def redirection
    redirect_to new_user_session_path format: :html if current_user.nil?
    redirect_to users_dashboard_path format: :html if current_user && current_user.user?
    redirect_to admins_dashboard_path format: :html if current_user && current_user.admin?
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admins_dashboard_path format: :html
    else
      users_dashboard_path format: :html
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path format: :html
  end
end
