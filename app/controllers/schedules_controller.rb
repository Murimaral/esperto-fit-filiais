class SchedulesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
  end

  def new
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @schedule = @subsidiary.build_schedule
  end

  def create
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @schedule = @subsidiary.build_schedule(schedule_params)

    if @schedule.save
      redirect_to subsidiary_schedule_path(@subsidiary), notice: 'Horários definidos com sucesso'
    else
      flash.now[:alert] = 'Não foi possível definir horários'
      render :new
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :holidays)
  end
end
