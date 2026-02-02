class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_path format: :html
    else
      users_dashboard_path format: :html
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path format: :html
  end
end
