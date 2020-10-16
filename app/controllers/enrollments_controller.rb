class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
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
end
