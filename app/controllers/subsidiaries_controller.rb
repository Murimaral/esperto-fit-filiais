class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    @subsidiary.images.attach(params[:subsidiary][:images])
    if @subsidiary.save
      redirect_to @subsidiary, notice: t('controllers.subsidiary.created')
    else
      flash.now[:alert] = t('controllers.subsidiary.creation_failed')
      render :new
    end
  end

  def update; end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :address, :cnpj, images: [])
  end
end
