class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = Request.where(user: current_user)
    @request = Request.new
    @employees = Employee.where(user: current_user)
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to requests_path, notice: "Request successfully created."
    else
      render :index, alert: "Request not created."
    end
  end

  private
  def request_params
    date = params[:request][:request_date].split('/')
    date.map!{|d| d.to_i}
    params.require(:request).permit(:employee_id, :request_type).merge(user: current_user, request_date: DateTime.new(date[2], date[0], date[1]).utc)
  end
end
