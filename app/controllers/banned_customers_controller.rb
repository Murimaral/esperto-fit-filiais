class BannedCustomersController < ApplicationController
  before_action :set_enrollment, only: %i[new create]
  def new
    @banned_customer = BannedCustomer.new
  end

  def create
    @banned_customer = BannedCustomer.new(banned_customer_params.merge(user: current_user, banned_at: Time.current,
                                                                       cpf: @enrollment.customer_cpf))

    if @banned_customer.save
      @enrollment.banned!
      redirect_to enrollments_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:enrollment_id])
  end

  def banned_customer_params
    params.require(:banned_customer).permit(:reason)
  end
end
