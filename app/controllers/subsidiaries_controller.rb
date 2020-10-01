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

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :address, :cnpj)
  end
end
