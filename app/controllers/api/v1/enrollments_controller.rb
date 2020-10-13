class Api::V1::EnrollmentsController < Api::V1::ApiController
  rescue_from ActionController::ParameterMissing, with: :render_precondition_failed
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.save!
    render status: :created, json: @enrollment
  end

  private

  def render_precondition_failed
    render status: :precondition_failed, json: 'Parâmetros inválidos'
  end

  def render_unprocessable_entity
    render status: :unprocessable_entity, json: @enrollment.errors.full_messages
  end

  def enrollment_params
    params.require(:enrollment).permit(:customer_name, :customer_cpf, :email, :subsidiary_plan_id, :price)
  end
end
