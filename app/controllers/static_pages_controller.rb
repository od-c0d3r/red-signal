class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [ :admin ]
  before_action :verify_user, only: [ :user ]

  def index; end

  def user; end

  def admin
    @online_users_with_long_lat = User.where(is_online: true, role: 0).where.not(latitude: nil, longitude: nil).to_json
    @events = Event.pluck(:longitude, :latitude, :title).to_json
  end

  private

  def verify_admin
    redirect_to root_path, notice: "You are not Authorized", format: :html unless current_user.admin?
  end

  def verify_user
    redirect_to root_path, notice: "You need to be a User", format: :html unless current_user.user?
  end
end
