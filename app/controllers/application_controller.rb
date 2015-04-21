class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action do
  #   resource = controller_path.singularize.gsub('/', '_').to_sym
  #   method = "#{resource}_params"
  #   params[resource] &&= send(method) if respond_to?(method, true)
  # end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'Usted no esta autorizado para acceder a la página solicitada.'
    redirect_to root_path
  end

  before_action do
    if user_signed_in? && current_user.tienda.present? && current_user.tienda.fecha_fin_contrato_actual < Date.today
      flash[:notice] = 'Usted posee el contrato de alquiler vencido, por favor dirigirse a administración para actualizar su contrato'
      sign_out current_user
    end
  end

  protected
    def self.permission
      self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def load_permissions
      @current_permissions = current_user.roles.each do |role|
        role.permissions.collect{|i| [i.subject_class, i.action]}
      end
    end

    def set_user
      @user = User.find_by(id: ActionController::Parameters.new(id: params[:id]).permit(:id)[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :locked, :mall_id, :cellphone, :role_id)#, rol_ids: [])
    end

    def params_id
      ActionController::Parameters.new(id: params[:id]).permit(:id)[:id]
    end

end
