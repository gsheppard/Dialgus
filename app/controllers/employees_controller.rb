class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = current_user.employees
    @employee = Employee.new

    @positions = current_user.positions
    @position = Position.new
  end

end
