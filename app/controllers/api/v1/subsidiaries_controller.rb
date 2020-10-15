class Api::V1::SubsidiariesController < Api::V1::ApiController
  def index
    @subsidiaries = Subsidiary.all
    render json: @subsidiaries
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])

    render json: SubsidiarySerializers::Show.new(@subsidiary)
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: 'Filial não encontrada'
  end
end
