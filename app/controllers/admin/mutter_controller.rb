class Admin::MutterController < ApplicationController
  require 'will_paginate'

  ####################################################################
  #つぶやき一覧
  ####################################################################
  def list
    #セッションで検索キーを保持
    session[:mutter_list] ||= Hash.new
    session[:mutter_list] = params[:mutter] if params[:mutter]
    session[:mutter_list][:order] = params[:order] if params[:order]
    session[:mutter_list][:page] = params[:page] if params[:page]

    #フォーム用に値を設定
    @mutter_serach = Mutter.new()
    @mutter_serach[:user_name] = session[:mutter_list] ? session[:mutter_list][:user_name] :nil
    @mutter_serach[:mutter] = session[:mutter_list] ? session[:mutter_list][:mutter] :nil
    @mutter_serach[:start_date] = session[:mutter_list]["start_date(1i)"] ?
      Date.new(session[:mutter_list]["start_date(1i)"].to_i,session[:mutter_list]["start_date(2i)"].to_i,session[:mutter_list]["start_date(3i)"].to_i) : Date.today
    @mutter_serach[:end_date] = session[:mutter_list]["end_date(1i)"] ?
      Date.new(session[:mutter_list]["end_date(1i)"].to_i,session[:mutter_list]["end_date(2i)"].to_i,session[:mutter_list]["end_date(3i)"].to_i) : Date.today

    #つぶやきDBより検索
    @mutter_list = Mutter.serach_and_paginate(@mutter_serach, session[:mutter_list][:page], session[:mutter_list][:order])
  end

  def delete
    Mutter.destroy(params[:id])
    redirect_to :action => :list
  end
end
