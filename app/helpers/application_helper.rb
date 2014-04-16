module ApplicationHelper

  def time_drop_down(datetime)
    # creates a drop down menu of times formatted as 12:30 PM
    # takes a DateTime object, ideally from
    # Shift.start_time or Shift.end_time
    drop_down = []
    quarters = [0,15,30,45]

    12.times do |hour|
      quarters.each do |quarter|
        drop_down << Time.new(2014,1,1,hour+10,quarter).strftime("%l:%M %p")
      end
    end

    if datetime == datetime.beginning_of_day
      drop_down.unshift("")
    else
      drop_down.unshift(datetime.strftime("%l:%M %p"))
    end
  end

  def strftime_to_military(time_string)
    # takes a string formatted as 7:00 AM / 12:30 PM
    # and converts it to 0700 / 1230 (military time)
    time = time_string.gsub(':', ' ').split(' ')
    time[0] = time[0].to_i

    if time[2] == 'PM' && time[0] != 12
      time[0] += 12
    end

    time.pop
    time = time.join('')
    time = "0" + time if time.length < 4
    time
  end

  def request_check(shift_obj)
    # takes a Shift object and checks if
    # the day of the shift matches a time off request
    requests = shift_obj.employee.requests
    vaca, sick = false, false

    requests.each do |request|
      if shift_obj.start_time >= request.request_date && shift_obj.start_time < request.request_date + 1.days
        vaca = true if request.request_type == 'Vacation'
        sick = true if request.request_type == 'Sick'
      end
    end

    if vaca || sick
      class_string = ""
      if vaca
        class_string << " vaca"
      elsif sick
        class_string << " sick"
      end

      return class_string
    end
  end

end
