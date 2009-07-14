class IndexController < ApplicationController
  def index
    session[:user_id] = 1
    @user = User.find(session[:user_id])

    @mutters = Mutter.find_home(@user.id)
    @favorites = Favorite.find_all_by_user_id(@user.id, :conditions => "delete_flg = 0")
  end
  
  def contribute
    unless params[:mutter_form][:mutter].blank?
      mutter = Mutter.new
      mutter.mutter = params[:mutter_form][:mutter]
      mutter.user_id = params[:mutter_form][:user_id]
      mutter.save
    end
    redirect_to("/index/")
  end

  def delete
    mutter = Mutter.find(params[:id])
    mutter.delete_flg = 1
    mutter.save
    redirect_to("/index/")
  end

  def favorite_regist
    favorite = Favorite.find_favorite(session[:user_id], params[:id])
    if favorite.blank?
      favorite = Favorite.new(:user_id => session[:user_id], :mutter_id => params[:id])
    else
      favorite.delete_flg = 0
    end
    favorite.save
    redirect_to("/index/")
  end

  def favorite_delete
    favorite = Favorite.find_favorite(session[:user_id], params[:id])
    favorite.delete_flg = 1
    favorite.save
    redirect_to("/index/")
  end
end
