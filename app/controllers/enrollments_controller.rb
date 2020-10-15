class EnrollmentsController < ApplicationController
  def index
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @enrollments = @subsidiary.enrollments
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end
end
