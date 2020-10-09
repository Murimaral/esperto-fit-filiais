class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    return redirect_to @plan if @plan.save

    render :new
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :default_price, :minimum_period)
  end
end
