class Admin::UsersController < ApplicationController
auto_complete_for :user, :name
require 'will_paginate'

  def index
    @users = User.all
    @user_search = User.new
    @users = User.paginate :page => params[:page], :order => 'id', :per_page => 10
  end
  
  def new
    @user = User.new
  end

  def passgene
    init_str =Time.now.utc.to_s #実用性も兼ねてUTC時間を繋げる
      #↑のを１文字ごとに文字コード（数値）に変換し、文字列に連結
      srand_use_str = ""
      init_str.split(//).each{|ch|
        srand_use_str << ch[0].to_s
      }
      #srandに↑の文字列(数値).to_iを渡す
      srand srand_use_str.to_i
      #75までの乱数を発生させて、その数字を文字コードとみなして文字化
      #a-zA-Z0-9の正規表現(\w)にマッチしたら文字列に加える
      #文字列が8文字になったらbreak
      new_pass = ""
      40.times{
        ch = (rand(75)+48).chr
        new_pass << ch if ch =~ /\w/
        break if new_pass.length == 8
      }
    return new_pass
  end


  def create
    @user = User.new(params[:user])
    p @user.pass = passgene
   
    #######################
    ##  戻るボタンの判定  ##
    #######################

    if params[:fix] 
      render :action => :new
      return
    end
    
    if @user.save
        email = OrderMailer.create_sent(@user.name,@user.pass,@user.mail)
        flash.now[:notice] = 'データを登録いたしました！'
        @user.pass = Digest::MD5.hexdigest("--my-salt--#{@user.pass}")
        @user.save
        render(:text => "<PRE>" + email.encoded + "</PRE>")
    end
  end

  def confirm
    @user = User.new(params[:user])
     if @user.validate
      flash.now[:notice] = '入力エラーです'
      render :action => :new
      return 
    end
  end
  
  def delete
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :action => :index
    rescue
    flash[:notice] = 'データベースから見つかりませんでした。リロードしておきました。'
    redirect_to :action => :index
  end
  
  def search
    #セッションで検索キーを保持するらしい
    @user = User.new
    session[:user_list] = nil
    session[:user_list] ||= Hash.new
   
    session[:user_list][:name] = params[:user][:name] if params[:user]
    session[:user_list][:mail] = params[:user][:mail] if params[:user]
    session[:user_list][:order] = params[:order] if params[:order]
    session[:user_list][:page]  = params[:page] if params[:page]
    session[:user_list][:follow_news_flg]  = params[:user][:follow_news_flg] if params[:user]
    session[:user_list][:now_place]  = params[:user][:now_place] if params[:user]

    
    @user_search = User.new
    @user_search[:name] = session[:user_list] ? session[:user_list][:name] :nil
    @user_search[:mail] = session[:user_list] ? session[:user_list][:mail] :nil
    @user_search[:follow_news_flg] = session[:user_list] ? session[:user_list][:follow_news_flg] :nil
    @user_search[:now_place] = session[:user_list] ? session[:user_list][:now_place] :nil
    @users = User.user_pagenate(@user_search,session[:user_list][:page],session[:user_list][:order])

    render :action => :index
  end
end


