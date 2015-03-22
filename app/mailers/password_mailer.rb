class PasswordMailer < ActionMailer::Base
  default from: "soporte@mailrental.com"

  def send_password(user, password)
    @user = user
    @password = password
    @host = 'http://localhost:3000'
    mail(to: user.email, subject: 'Registro de Usuario MailRental')
  end
end