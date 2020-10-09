class SubsidiaryPlansController < ApplicationController
  before_action :set_subsidiary_plans, only: %i[new]

  def new
    @subsidiary_plan = SubsidiaryPlan.new
  end

  def create
    @subsidiary_plan = SubsidiaryPlan.new(subsidiary_plan_params)
    return redirect_to subsidiary_path(params[:subsidiary_id]), notice: t('.created') if @subsidiary_plan.save

    set_subsidiary_plans
    flash.now[:alert] = t('.not_created')
    render :new
  end

  private

  def subsidiary_plan_params
    params.require(:subsidiary_plan).permit(:plan_id, :final_price, :status)
          .merge(subsidiary_id: params[:subsidiary_id])
  end

  def set_subsidiary_plans
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @plans = Plan.where.not(id: @subsidiary.plans.ids)
  end
end
