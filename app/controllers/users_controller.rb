class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_user

  def dashboard; end

  def update_status
    current_user.update(is_online: !current_user.is_online)
  end

  def update_location
    return head :too_many_requests if current_user.updated_at > 3.seconds.ago

    current_user.update(latitude: params[:latitude], longitude: params[:longitude])

    head :ok
  end

  private
  def verify_user
    redirect_to admin_path, notice: "You need to be a User", format: :html unless current_user.user?
  end
end
