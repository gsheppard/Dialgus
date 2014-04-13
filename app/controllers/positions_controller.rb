class PositionsController < ApplicationController
  def create
    @position = Position.new(position_params.merge(user: current_user))

    if @position.save
      redirect_to employees_path, notice: 'Position created'
    else
      redirect_to employees_path, alert: 'Position not saved'
    end
  end

  def show
    redirect_to employees_path
  end

  private
  def position_params
    params.require(:position).permit(:name)
  end
end
