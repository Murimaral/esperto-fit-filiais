class Api::V1::EnrollmentsController < Api::V1::ApiController
  rescue_from ActionController::ParameterMissing, with: :render_precondition_failed
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def create
    @subsidiary_plan = SubsidiaryPlan.find_by(plan_id: params[:plan_id], subsidiary_id: params[:subsidiary_id])
    @enrollment = Enrollment.new(**enrollment_params, subsidiary_plan_id: @subsidiary_plan.id)
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
