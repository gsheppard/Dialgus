class PositionsController < ApplicationController
  def index
    redirect_to employees_path
  end

  def create
    @position = Position.new(position_params.merge(user: current_user))

    if @position.save
      redirect_to employees_path, notice: 'Position created'
    else
      @employee = Employee.new
      @employees = current_user.employees
      @positions = current_user.positions
      render 'employees/index'
    end
  end

  def show
    redirect_to employees_path
  end

  def destroy
    @position = Position.find(params[:id])

    if @position.destroy
      flash[:notice] = "Position successfully deleted"
    else
      flash[:alert] = "Position could not be deleted"
    end

    redirect_to employees_path
  end

  private
  def position_params
    params.require(:position).permit(:name)
  end
end
