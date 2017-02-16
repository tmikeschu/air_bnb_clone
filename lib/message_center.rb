module MessageSender
  def self.send_code(phone_number, code)
    account_sid = ENV['twilio_account_sid']
    auth_token  = ENV['twilio_auth_token']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
      from:  ENV['twilio_number'],
      to:    phone_number,
      body:  code
    )

    message.status == 'queued'
  end
end
