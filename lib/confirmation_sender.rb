require_relative 'code_generator'
require_relative 'message_center'

module ConfirmationSender
  include CodeGenerator
  def self.send_confirmation_to(user)
    verification_code = CodeGenerator.generate
    user.update(verification_code: verification_code)
    MessageSender.send_code(ENV['twilio_test_number'], verification_code)
  end
end
