class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def verificar_login
    unless logged_in?
      flash[:alert] = "Você precisa fazer login para acessar esta página."
      redirect_to root_path
    end
  end

  def redirecionar_se_logado
    if logged_in?
      redirect_to home_path
    end
  end
end
