module ApplicationHelper

  def time_drop_down(datetime)
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

end
