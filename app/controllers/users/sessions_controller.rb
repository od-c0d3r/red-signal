# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :switch_to_offline, only: :destroy

  private

  def switch_to_offline
    current_user.update(is_online: false) if current_user.user? && current_user.is_online
  end
end
