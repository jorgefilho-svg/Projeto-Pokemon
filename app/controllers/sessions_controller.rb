class SessionsController < ApplicationController
  before_action :redirecionar_se_logado, only: [ :new, :create ]
  def new
  end

  def create
    usuario = User.find_by(email: params[:email])

    if usuario && usuario.authenticate(params[:password])
      # gerando um token toda vez que o user fizer login.
      session[:user_id] = usuario.id
      redirect_to home_path, notice: "Sessão iniciada com sucesso!"

    else
      flash.now[:alert] = "E-mail ou palavra-passe inválidos." # exibi a msg de erro.
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Terminou a sessão com sucesso."
  end
end
