class OrderMailer < ActionMailer::Base
  

  def sent(name,pass,mail)
    subject    'OrderMailer#sent'
    recipients mail
    from        'matsuritter@needswell.com'
    sent_on    Time.now
    body       :name => name, :pass => pass ,:mail => mail
  end

  def newsletter(subject,mail,body)
    subject    subject
    recipients mail
    from        'matsuritter@needswell.com'
    sent_on    Time.now
    body        body
  end

  def mail_enc(mail)
    mails =''
    mail.each{|m|
     mails = m.mail + '; ' + mails
    }
    return mails
  end

end
