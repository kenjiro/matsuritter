class Admin::UsersController < ApplicationController
auto_complete_for :user, :name

  def index
   
    @users = User.all
    @user = User.new
  end
  
  def new
    @user = User.new
  end

  def create
    #######################
    ##  戻るボタンの判定  ##
    #######################
    if params[:fix]
      @user = User.new(params[:user])
      render :action => :new
      return
    end
    
    @user = User.new(params[:user])
    if @user.save
        email = OrderMailer.create_sent(@user.name,@user.pass,@user.mail)
        flash.now[:notice] = 'データを登録いたしました！'
       render(:html => "<PRE>" + email.encoded + "</PRE>")
    end
  end

  def confirm
    @user = User.new(params[:user])
    if @user.validate
      flash.now[:notice] = '入力エラーです'
      render :action => :new
    end
  end
  
  def delete
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :action => :index
  end
  
end
