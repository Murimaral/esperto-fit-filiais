class Api::V1::BannedCustomersController < Api::V1::ApiController
  def show
    banned_cpf = CPF.new(params[:cpf]).formatted
    return render status: :unprocessable_entity, json: { message: 'CPF inválido' } unless CPF.valid?(banned_cpf)

    @banned_customer = BannedCustomer.find_by(cpf: banned_cpf)
    if @banned_customer
      render status: :ok
    else
      render status: :not_found
    end
  end
end
