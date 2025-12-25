class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def user; end

  def admin; end
end
