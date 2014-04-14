class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = current_user.employees
    @employee = Employee.new

    @positions = current_user.positions
    @position = Position.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.valid?
      @employee.save
      redirect_to employees_path
    else
      @employees = current_user.employees
      @positions = current_user.positions
      @position = Position.new

      render :index
    end
  end

  private
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :position_id, :work_type).merge(user: current_user)
  end

end
