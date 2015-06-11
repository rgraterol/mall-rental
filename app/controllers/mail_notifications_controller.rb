class MailNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_mall
  # authorize_resource class: :mail_notifications

  # Notifica a todos los usuarios de las tiendas con
  # contrato de alquiler vencido
  def mf_notify_tiendas_mall
    current_user.mall.tiendas.each do |tienda|
      if tienda.contrato_alquilers.last.fecha_fin < Date.today
        tienda.users.each do |user|
          NotificacionesMailer.notify_tiendas_mall(user)
        end
      end
    end
  end

  def mf_notify_tiendas_no_actualizadas
    current_user.mall.tiendas.each do |tienda|
      tienda.users.each do |user|
        NotificacionesMailer.notify_tiendas_no_actualizadas(user)
      end

    end
  end



  private
    def self.permission
      'mail_notifications'
    end
end