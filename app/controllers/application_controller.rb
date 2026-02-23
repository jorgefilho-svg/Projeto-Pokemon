class ApplicationController < ActionController::API
  def verificar_login
    # ver se não tem token no header da requisição
    token_enviado = request.headers["Authorization"]

    if token_enviado.blank?
      render json: { erro: "Acesso negado. Você precisa enviar o token." }, status: :unauthorized
      return
    end
    # procurar user com esse token no banco de dados.
    usuario_atual = User.find_by(token: token_enviado)

    # se não encontrar, devolver erro de acesso negado.
    if usuario_atual.nil?
      render json: { erro: "Acesso negado. Faça login para continuar." }, status: :unauthorized
    end
  end
end
