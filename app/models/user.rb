class User < ActiveRecord::Base
  has_many   :mutters

  def validate
    if name.to_s.empty?
      errors.add(:name, "が入力されていません")
    end
     if pass.to_s.empty?
      errors.add(:pass, "が入力されていません")
    end
     if mail.to_s.empty?
      errors.add(:mail, "が入力されていません")
     else if  !mail.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/)
      errors.add(:mail, "書式が変です")
     end
    end
  end
end
