class IndexController < ApplicationController
  include AppConst
  include AppDate
#  before_filter :set_user_and_count, :only => [:index, :favorite, :profile, :replies]
  after_filter :not_reply, :except => [:index, :reply]

  def index
    session[:user_id] = 1
    set_user_and_count
    @mutters = Mutter.find_home(@user.id, @count)
    @reply_user = session[:reply][:user_name] + " に返事する" unless session[:reply].blank?
  end

  def favorite
    set_user_and_count
    @mutters = Mutter.find_favorites(@user.id, @count)
  end

  def profile
    set_user_and_count
    @mutters = Mutter.find_profile(@user.id, @count)
  end

  def replies
    set_user_and_count
    @mutters = Mutter.find_replies(@user.id, @count)
  end

  def contribute
    unless params[:mutter_form][:mutter].blank?
      mutter = Mutter.new
      mutter.mutter = params[:mutter_form][:mutter]
      mutter.user_id = params[:mutter_form][:user_id]

      unless session[:reply].blank?
        return_mutter = ReturnMutter.new
        return_mutter.user_id = session[:reply][:user_id]
        return_mutter.mutter_id = session[:reply][:mutter_id]
        return_mutter.save

        mutter.res_flg = RES_FLG[:setting]
        mutter.return_mutter_id = return_mutter.id
      end
      mutter.save
    end
    redirect_to("/index/")
  end

  def reply
    session[:reply] = Hash.new
    mutter = Mutter.find(params[:id])
    session[:reply][:user_id] = mutter.user_id
    session[:reply][:user_name] = mutter.user.name
    session[:reply][:mutter_id] = mutter.id
    redirect_to("/index/")
  end

  def delete
    mutter = Mutter.find(params[:id])
    mutter.delete_flg = DELETE_FLG[:setting]
    mutter.save
    redirect_to(request.referer)
  end

  def favorite_regist
    favorite = Favorite.find_favorite(session[:user_id], params[:id])
    if favorite.blank?
      favorite = Favorite.new(:user_id => session[:user_id], :mutter_id => params[:id])
    else
      favorite.delete_flg = DELETE_FLG[:unsetting]
    end
    favorite.save
    redirect_to(request.referer)
  end

  def favorite_delete
    favorite = Favorite.find_favorite(session[:user_id], params[:id])
    favorite.delete_flg = DELETE_FLG[:setting]
    favorite.save
    redirect_to(request.referer)
  end

  private
  def set_user_and_count
    @user = User.find(session[:user_id])
    @count = (params[:id].blank? ? 0 : params[:id].to_i) + MUTTER[:display_number]
  end

  def not_reply
    session[:reply] = nil
  end
end
