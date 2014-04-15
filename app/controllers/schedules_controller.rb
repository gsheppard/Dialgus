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
    @employees = Employee.where(user: current_user)

    if @schedule.save
      @employees.each do |emp|
        7.times do |n|
          Shift.create(
            employee: emp,
            schedule: Schedule.where(week_of: @schedule.week_of).first,
            start_time: @schedule.week_of + n.days,
            end_time: @schedule.week_of + n.days
          )
        end
      end

      redirect_to schedule_path(@schedule), notice: 'Schedule created successfully.'
    else
      redirect_to schedules_path, alert: 'Oops! Something happened.'
    end
  end

  def show

  end

  private
  def schedule_params
    params.require(:schedule).permit(:week_of).merge(user: current_user)
  end
end
