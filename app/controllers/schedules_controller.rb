class SchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.employees.count < 1
      redirect_to employees_path, alert: "Please create an employee before continuing."
    end

    @schedules = Schedule.where(user: current_user).order(:week_of).limit(10)
    @schedule = Schedule.new
    @upcoming = []

    7.times do |num|
      sunday = DateTime.now.utc.beginning_of_week(:sunday) + (num + 1).weeks
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
    @week = Schedule.find(params[:id])
    @shifts = build_employee_shifts

    @weekdays = []
    7.times do |n|
      @weekdays << @week.week_of + n.days
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:week_of).merge(user: current_user)
  end

  def build_employee_shifts
    schedule = Schedule.find(params[:id])
    schedules = Shift.where(schedule: schedule).order(:start_time)
    employees = Employee.where(user: current_user)

    shifts = {}
    employees.each do |emp|
      shifts[emp] ||= []

      schedules.each do |sched|
        if sched.employee == emp
          shifts[emp] << sched
        end
      end
    end

    shifts
  end
end
