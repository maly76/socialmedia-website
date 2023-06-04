Clearance.configure do |config|
  config.allow_sign_up = true
  config.routes = true
  config.mailer_sender = "reply@example.com"
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = "/"
  config.rotate_csrf_on_sign_in = true
  config.sign_in_guards = []
  config.user_model = "User"
  config.parent_controller = "ApplicationController"
end
