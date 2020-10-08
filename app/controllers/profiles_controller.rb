class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
    @profile.build_user
    @subsidiaries = Subsidiary.all
  end

  def create
    @profile = Profile.create!(profile_params)
    redirect_to @profile, notice: 'Usuário cadastrado com sucesso!'
  end

  def show
  end

  private
  def profile_params
    params.require(:profile).permit(:full_name,:cpf,:address,:subsidiary_id, user_attributes: [:email, :password, :role])
  end
end