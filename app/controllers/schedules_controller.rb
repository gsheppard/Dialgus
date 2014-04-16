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

  def update
    @week = Schedule.find(params[:id])
    @shifts = build_employee_shifts
    shift_data = {}

    shifts_params.each do |employee, shifts|
      employee_id = employee.gsub(/\D/, '').to_i
      # shifts format is shift_{weekday}_{id}
      shifts.each do |id, startend|
        # startend["start_time"] and startend["end_time"]
        shift_id = id.split('_')[1..2]
        # shift_id[0] is weekday, shift_id[1] is schedule.id

        start_time = s_to_time(@week.week_of, startend["start_time"]) + shift_id[0].to_i.days
        end_time = s_to_time(@week.week_of, startend["end_time"]) + shift_id[0].to_i.days

        s = Shift.find(shift_id[1])
        if s.start_time != start_time || s.end_time != end_time
          s.update_attributes(start_time: start_time, end_time: end_time)
        end
      end
    end

    redirect_to schedule_path(@week)
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

  def shifts_params
    params.require(:schedule)
  end

  def s_to_time(week, time)
    # week is the seed data for year/month/day
    # time is the time formatted as 1730
    if time.blank? || time.nil? || time == "0"
      hour = 0
      minute = 0
    else
      time = time.split('')
      hour = (time[0] + time[1]).to_i
      minute = (time[2] + time[3]).to_i
    end

    DateTime.new(
      week.year,
      week.month,
      week.day,
      hour,
      minute
    )
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
