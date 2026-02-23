class User < ApplicationRecord
  # ativar criptografia de senha e validção da presença dela
  has_secure_password
  has_secure_token :token
  # validar a presença dos campos obrigatórios para criar um usuário
  validates :name, :email, :birthdate, :gender, presence: true
  # validar a unicidade do email para evitar duplicatas, o 'case_sensitive: false' garante que mesmo letras maiuculas ou minúsculas sejam consideradas iguais
  validates :email, uniqueness: { case_sensitive: false }
  # não permitir cadastro de um genêro diferente dos pré-definidos.
  validates :gender, inclusion: {
    in: [ "Masculino", "Feminino", "Não Binário" ],
    message: "%{value} não é um gênero válido"
  }
end
