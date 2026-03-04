class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(parametros_permitidos)

    if @user.save
      redirect_to root_path, notice: "Cadastro realizado com sucesso! Faça seu login."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def parametros_permitidos
    params.require(:user).permit(:name, :last_name, :email, :password, :birthdate, :gender)
  end
end
