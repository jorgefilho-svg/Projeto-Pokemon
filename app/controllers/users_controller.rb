class UsersController < ApplicationController
  def create
    # Criação do usuário:
    usuario = User.new(parametros)

    # condicional para tentativa de salvar o usuário no banco.
    if usuario.save
      # se salvou, devolve mensagem de sucesso com os dados do usuário (exceto a senha)
      render json: {
        mensagem: "Usuário cadastrado com sucesso!",
        usuario: { id: usuario.id, name: usuario.name, surname: usuario.surname, email: usuario.email }
      }, status: :created
    else
      # se falhou, devolve o erro de validação.
      render json: { erros: usuario.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # mtd privado para permitir só esses parametros.
  def parametros
    params.permit(:name, :surname, :email, :password, :birthdate, :gender)
  end
end
