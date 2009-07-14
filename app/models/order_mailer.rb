class OrderMailer < ActionMailer::Base
  

  def sent(name,pass,mail)
    subject    'OrderMailer#sent'
    recipients mail
    from        'matsuritter@needswell.com'
    sent_on    Time.now
    body       :name => name,:pass => pass,:mail => mail
  end

end
