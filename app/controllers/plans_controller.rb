class PlansController < ApplicationController
  def index; end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to @plan
    else
      render :new
    end
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :default_price, :minimum_period)
  end
end
