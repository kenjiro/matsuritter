class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :mutter

  def self.find_favorite(user_id, mutter_id)
    find_by_user_id_and_mutter_id(user_id,
                                  mutter_id,
                                  :conditions => "delete_flg = 0")
  end
end
