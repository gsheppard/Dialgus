class SchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @schedules = Schedule.where(user: current_user).order(:week_of).limit(10)
    @schedule = Schedule.new
    @upcoming = []

    7.times do |num|
      sunday = DateTime.now.beginning_of_week(:sunday) + (num + 1).weeks
      if Schedule.new(user:current_user,week_of:sunday).valid?
        @upcoming << sunday
      end
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      redirect_to schedule_path(@schedule)
    else
      render :index
    end
  end

  def show

  end

  private
  def schedule_params
    params.require(:schedule).permit(:week_of).merge(user: current_user)
  end
end
