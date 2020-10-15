class SchedulesController < ApplicationController
  before_action :set_subsidiary, only: %i[show new create edit update]
  before_action :set_schedule, only: %i[edit update]

  def show; end

  def new
    @schedule = @subsidiary.build_schedule
  end

  def create
    @schedule = @subsidiary.build_schedule(schedule_params)

    if @schedule.save
      redirect_to subsidiary_schedule_path(@subsidiary), notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  def edit
    redirect_to subsidiary_schedule_path(@subsidiary) unless @schedule
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to subsidiary_schedule_path(@subsidiary), notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :edit
    end
  end

  private

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
  end

  def set_schedule
    @schedule = @subsidiary.schedule
  end

  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :holidays)
  end
end
