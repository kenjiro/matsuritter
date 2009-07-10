class Admin::MutterController < ApplicationController
  require 'will_paginate'
  def list
    @mutters = Mutter.paginate(:all,
                               :order => "created_at",
                               :include => :user,
                               :page => params[:page],
                               :per_page => 1)
  end

end
