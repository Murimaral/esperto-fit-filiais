class Api::V1::EnrollmentsController < Api::V1::ApiController
  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.save!
    render json: @enrollment, status: :created
  rescue ActionController::ParameterMissing
    render status: :precondition_failed, json: 'Parâmetros inválidos'
  rescue ActiveRecord::RecordInvalid
    render status: :unprocessable_entity, json: @enrollment.errors.full_messages
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:customer_name, :customer_cpf, :email, :subsidiary_plan_id, :price)
  end
end
