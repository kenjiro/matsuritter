class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
    p @users
    p @user
  end
  
  def new
    @user = User.new
    p @user
  end

  def create
    @user = User.new(params[:user])
    @user.save
    p @user
  end

  def confirm
    @user = User.new(params[:user])
    p @user
  end
  
  def delete
   
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :action => :index
  end


end
