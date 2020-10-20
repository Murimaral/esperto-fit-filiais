class EnrollmentsController < ApplicationController
  def index
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @enrollments = @subsidiary.enrollments
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end

  def cancel
    @enrollment = Enrollment.find(params[:id])
    @enrollment.canceled!
    redirect_to @enrollment
  end
end
