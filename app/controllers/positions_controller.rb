class PositionsController < ApplicationController
  before_filter :authenticated?

  def index
    # all
    @positions = current_user.positions
    # new
    @position = Position.new
  end

  private
  def authenticated?
    unless current_user
      redirect_to root_path, alert: 'Access Denied'
    end
  end
end
