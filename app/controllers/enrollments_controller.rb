class EnrollmentsController < ApplicationController
  def index
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @enrollments = @subsidiary.enrollments
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end

  def search
    @enrollments = Enrollment.where("token LIKE UPPER(:search)
                                    OR customer_cpf LIKE :search
                                    OR customer_name LIKE :search ", { search: "%#{params[:q]}%" })
    render :index
  end

  def cancel
    @enrollment = Enrollment.find(params[:id])
    @enrollment.canceled!
    redirect_to @enrollment
  end
end
