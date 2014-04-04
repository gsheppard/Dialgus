class EmployeesController < ApplicationController
  before_filter :authenticated?

  def index
    @employees = current_user.employees
    @employee = Employee.new
    @positions = current_user.positions
  end

end
