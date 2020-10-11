class BannedCustomersController < ApplicationController
  before_action :set_enrollment, only: %i[new create]
  def new
    @banned_customer = BannedCustomer.new
  end

  def create
    @banned_customer = BannedCustomer.new(banned_customer_params)

    @banned_customer.save_and_send_to_api(@enrollment)
    redirect_to enrollments_path, notice: t('.success')
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('.fail')
    render :new
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:enrollment_id])
  end

  def banned_customer_params
    params.require(:banned_customer).permit(:reason, :cpf)
          .merge(user: current_user)
  end
end
