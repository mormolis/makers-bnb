require 'gmail'

class Gmailer
  attr_reader :gmail

  def login(username, password)
    @gmail = Gmail.connect(username, password)
    return gmail.logged_in?
  end

  def logout
    gmail.logout if gmail.logged_in?
  end

  def send_email(email_args)
    throw Error("You have to log in to GMAIL first") unless gmail.logged_in?
    gmail.deliver do
      to email_args[:recipient]
      subject email_args[:email_subject]
      text_part do
        body email_args[:message]
      end
    end
  end

end
