 class Admin::MainController < ApplicationController
   def index
     session[:test] = "動いてるのかなー？"
   end
 end
