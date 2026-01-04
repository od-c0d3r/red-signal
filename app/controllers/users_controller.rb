class UsersController < ApplicationController
  def update_status
    @online_users_with_long_lat = User.where(is_online: true).where.not(latitude: nil, longitude: nil)

    current_user.update(is_online: params[:is_online])
  end

  def update_location
    return head :too_many_requests if current_user.updated_at > 3.seconds.ago

    current_user.update(latitude: params[:latitude], longitude: params[:longitude])

    head :ok
  end
end
