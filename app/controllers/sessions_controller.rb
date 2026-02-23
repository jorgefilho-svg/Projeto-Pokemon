class SessionsController < ApplicationController
  def create
    usuario = User.find_by(email: params[:email])

    if usuario && usuario.authenticate(params[:password])
      # gerando um token toda vez que o user fizer login.
      usuario.regenerate_token

      render json: {
        mensagem: "Login realizado com sucesso!",
        token: usuario.token # entregar o token.
      }, status: :ok
    else
      render json: { erro: "E-mail ou senha inválidos" }, status: :unauthorized
    end
  end
end
