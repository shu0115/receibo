# coding: utf-8
class AdminController < ApplicationController
  # 管理者以外リダイレクト
  before_filter :admin_authorize

  #-------#
  # users #
  #-------#
  def users
    @users = User.all
  end

  private
  #-----------#
  # authorize #
  #-----------#
  def admin_authorize
    user = User.where( :id => session[:user_id] ).select( :twitter_id ).first
print "[ user ] : " ; p user ;
    redirect_to :root unless user.twitter_id.to_i == 14369656
  end

end
