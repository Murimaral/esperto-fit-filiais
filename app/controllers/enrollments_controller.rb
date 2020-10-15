class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end

  def cancel
    @enrollment = Enrollment.find(params[:enrollment_id])
    @enrollment.canceled!
    redirect_to @enrollment
  end
end
