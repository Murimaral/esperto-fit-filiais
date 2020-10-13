class BannedCustomersController < ApplicationController
  before_action :set_enrollment, only: %i[new create]

  def show
    @banned_customer = BannedCustomer.find(params[:id])
  end

  def new
    @banned_customer = BannedCustomer.new
  end

  def create
    @banned_customer = BannedCustomer.new(banned_customer_params)

    handle_invalid_record_fail and return unless @banned_customer.valid?
    handle_send_data_to_api_fail and return unless @banned_customer.send_data_to_customers_api

    @banned_customer.save
    @enrollment.banned!

    redirect_to @banned_customer, notice: t('.success')
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:enrollment_id])
  end

  def handle_invalid_record_fail
    render_fail('.fail')
  end

  def handle_send_data_to_api_fail
    render_fail('.api_fail')
  end

  def render_fail(msg)
    flash.now[:alert] = t(msg)
    render :new
  end

  def banned_customer_params
    params.require(:banned_customer).permit(:reason, :cpf)
          .merge(user: current_user)
  end
end
