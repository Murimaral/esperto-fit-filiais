class SubsidiariesController < ApplicationController
  def index; end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)

    if @subsidiary.save
      redirect_to @subsidiary, notice: 'Filial criada com sucesso!'
    else
      flash.now[:alert] = 'A filial não foi criada.'
      render :new
    end
  end

  def schedule
    @subsidiary = Subsidiary.find(params[:id])
    @schedule = @subsidiary.build_schedule
  end

  def create_schedule
    @subsidiary = Subsidiary.find(params[:id])
    @subsidiary.create_schedule!(schedule_params)
    redirect_to @subsidiary, notice: 'Horários atualizados com sucesso'
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :address, :cnpj)
  end

  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :holidays)
  end
end
