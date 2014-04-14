class SchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @schedules = Schedule.where(user: current_user).order(:week_of).limit(10)
  end
end
