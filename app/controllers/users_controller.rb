class UsersController < ApplicationController
  def update_user_status
    current_user.update(is_online: params[:is_online])
  end
end
