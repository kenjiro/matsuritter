class Mutter < ActiveRecord::Base
  include AppConst

  belongs_to :user
  has_many :favorites
  belongs_to :return_mutter

  validates_length_of(:mutter, :maximum => MUTTER[:max_length])

  def self.search_and_paginate(obj, page, order)
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

  def self.find_home(user_id, limit=MUTTER[:display_number])
    find(:all,
         :include => :return_mutter,
         :conditions => ["(mutters.user_id = ?
                          or mutters.user_id in(select follow_user_id from follows where user_id = ? and delete_flg = ?))
                         and (return_mutters.user_id in(select follow_user_id from follows where user_id = ? and delete_flg = ?) or return_mutters.user_id is null)
                         and mutters.delete_flg = ?",
                         user_id, user_id, DELETE_FLG[:unsetting], user_id, DELETE_FLG[:unsetting], DELETE_FLG[:unsetting]],
#         :conditions => ["(user_id = ? or user_id in(select follow_user_id from follows where user_id = ? and delete_flg = ?)) and delete_flg = ?", user_id, user_id, DELETE_FLG[:unsetting], DELETE_FLG[:unsetting]],
         :limit => limit,
         :order => "mutters.created_at DESC"
    )
  end

  def self.find_favorites(user_id, limit=MUTTER[:display_number])
    find(:all,
         :include => :favorites,
         :conditions => ["favorites.user_id = ? and favorites.delete_flg = ? and mutters.delete_flg = ?", user_id, DELETE_FLG[:unsetting], DELETE_FLG[:unsetting]],
         :limit => limit,
         :order => "mutters.created_at DESC"
    )
  end

  def self.find_profile(user_id, limit=MUTTER[:display_number])
    find(:all,
         :conditions => ["user_id = ? and delete_flg = ?", user_id, DELETE_FLG[:unsetting]],
         :limit => limit,
         :order => "created_at DESC"
    )
  end

  def self.find_replies(user_id, limit=MUTTER[:display_number])
    find(:all,
         :include => :return_mutter,
         :conditions => ["return_mutters.user_id = ? and mutters.delete_flg = ? and return_mutters.delete_flg = ?", user_id, DELETE_FLG[:unsetting], DELETE_FLG[:unsetting]],
         :limit => limit,
         :order => "mutters.created_at DESC"
    )
  end
end
