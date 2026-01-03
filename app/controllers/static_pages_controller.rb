class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:admin]
  before_action :verify_user, only: [:user]

  def index; end

  def user; end

  def admin
    @users_with_long_lat = User.where.not(latitude: nil, longitude: nil)

    Rails.logger.info "Users with long/lat: #{@users_with_long_lat.pluck(:id, :latitude, :longitude).to_json}"
  end

  private

  def verify_admin
    redirect_to admin_dashboard_path format: :html unless current_user.admin?
  end

  def verify_user
    redirect_to user_dashboard_path format: :html unless current_user.user?
  end
end
