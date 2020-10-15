class PlansController < ApplicationController
  before_action :set_plan, only: %i[show edit update]
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

  def show; end

  def edit; end

  def update
    return redirect_to @plan if @plan.update(plan_params)

    render :edit
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :default_price, :minimum_period)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
