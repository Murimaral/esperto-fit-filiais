class SubsidiaryPlansController < ApplicationController
  def new
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @subsidiary_plan = SubsidiaryPlan.new
    @plans = Plan.all
  end

  def create
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @plans = Plan.all
    @subsidiary_plan = SubsidiaryPlan.new(subsidiary_plan_params)
    if @subsidiary_plan.save
      redirect_to subsidiary_path(params[:subsidiary_id])
    else
      flash.now[:alert] = 'Não foi possível cadastrar plano'
      render :new
    end
  end

  private

  def subsidiary_plan_params
    params.require(:subsidiary_plan).permit(:plan_id, :final_price, :status)
          .merge(subsidiary_id: params[:subsidiary_id])
  end
end
