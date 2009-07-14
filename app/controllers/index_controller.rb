class IndexController < ApplicationController

  def index
    @user_id = 1
    @mutters = Mutter.find_home(@user_id)
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
end
