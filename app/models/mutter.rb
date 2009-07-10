class Mutter < ActiveRecord::Base
  belongs_to :user

  def self.serach_and_paginate(obj, page, order)
   #条件式作成
   condition_str = ""
   search_hash = Hash.new
   unless obj.user_name.blank?
     condition_str << "users.name LIKE :user_name"
     search_hash[:user_name] = '%' + obj.user_name + '%'
   end
   unless obj.mutter.blank?
     condition_str << " and mutter LIKE :mutter"
     search_hash[:mutter] = '%' +obj.mutter + '%'
   end
   if obj.start_date && obj.end_date
     condition_str << " and mutters.created_at BETWEEN :start_date AND :end_date"
     search_hash[:start_date] = obj.start_date
     search_hash[:end_date] = obj.end_date
   end
   if condition_str[0,5] =~ / and /
     condition_str[0,5] = ""
   end

   #ORDERBY設定
   order_by = order ? order : "mutters.created_at"

   @mutter_list = paginate(:all,
                             :conditions => [condition_str, search_hash],
                             :order => order_by,
                             :include => :user,
                             :page => page,
                             :per_page => 2)
  end

end
