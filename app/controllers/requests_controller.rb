class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = Request.where(user: current_user)
    @request = Request.new
    @employees = Employee.where(user: current_user)
  end
end
