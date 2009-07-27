class User < ActiveRecord::Base
  has_many :mutters
  has_many :return_mutters
  has_many :follows
  has_many :favorites

  def validate
    # I tried but returning errors do not work well!
    flg = nil
    if name.to_s.empty?
      errors.add(:name, "asasa")
      flg = 1
    end
    
    if mail.to_s.empty?
      errors.add(:mail, "121313")
      flg = 1
    elsif  !mail.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/)
      errors.add(:mail, "書式が変です")
      flg = 1
    end
    return flg
  end

  def self.user_pagenate(obj,page,order)
  #条件式作成
  #conditon_str がプレースホルダ
  #search_hash がプレースホルダの中身を示す（こいつは、ハッシュ)

  conditions_str = ""
  search_hash    = Hash.new
  unless obj.name.blank? #名前が空でなければ
    conditions_str << "users.name LIKE :user_name"
    search_hash[:user_name] = obj.name + '%'
  end
  unless obj.mail.blank?
    conditions_str << " and mail LIKE :mail"
    search_hash[:mail] = '%' + obj.mail + '%'
  end
  unless obj.now_place.blank?
    conditions_str << " and now_place = :now_place"
    search_hash[:now_place] = obj.now_place
  end
  unless obj.follow_news_flg.blank?
    conditions_str << " and follow_news_flg = :follow_news_flg"
    search_hash[:follow_news_flg] = obj.follow_news_flg
  end

   #andから始まるSQLが出来ないように[and]があったら、削る
  if conditions_str[0,5] =~ /and/
    conditions_str[0,5] = ""
  end

    order_by = order ? order : "users.name"

    @users = paginate(:all,
                       :conditions =>[conditions_str,search_hash],
                       :order => order_by,
                       :page => page,
                       :per_page => 10)
  end
end