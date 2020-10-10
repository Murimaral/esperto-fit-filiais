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
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to @profile, notice: 'Usuário cadastrado com sucesso!'
    else
      @subsidiaries = Subsidiary.all
      render :new
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :cpf, :address, :subsidiary_id,
                                    user_attributes: %i[id email password role])
  end
end
