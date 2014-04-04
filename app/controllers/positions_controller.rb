class PositionsController < ApplicationController
  before_filter :authenticated?

  def index
    # all
    @positions = current_user.positions
    # new
    @position = Position.new
  end

end
