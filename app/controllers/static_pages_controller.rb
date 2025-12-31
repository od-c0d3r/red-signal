class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:admin]
  before_action :verify_user, only: [:user]

  def index; end

  def user; end

  def admin; end

  private

  def verify_admin
    redirect_to admin_dashboard_path format: :html unless current_user.admin?
  end

  def verify_user
    redirect_to user_dashboard_path format: :html unless current_user.user?
  end
end
