class NotificacionesMailer < ActionMailer::Base
  default from: "soporte@mailrental.com"

  def notify_tiendas_mall(user)
    @user = user
    @host = 'http://mall-rental.us.to'
    mail(to: user.email, subject: "Notificación sobre su tienda en #{user.mall.nombre}")
  end

  def notify_tiendas_no_actualizadas(user)

  end
end
