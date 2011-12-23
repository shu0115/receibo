# coding: utf-8
class AdminController < ApplicationController

  # 管理者以外リダイレクト
  before_filter :admin_authorize

  #-------#
  # users #
  #-------#
  def users
    @users = User.all( :order => "id DESC" )
    @item_count = Item.count
  end

  private

  #-----------#
  # authorize #
  #-----------#
  def admin_authorize
    user = User.where( :id => session[:user_id] ).select( :twitter_id ).first

    if defined? ADMIN_USER_TWITTER_ID_1
      admin_twitter_id = ADMIN_USER_TWITTER_ID_1
    elsif defined? ENV['ADMIN_USER_TWITTER_ID_1']
      admin_twitter_id = ENV['ADMIN_USER_TWITTER_ID_1']
    else
      admin_twitter_id = 0
    end

    redirect_to :root unless user.try(:twitter_id).to_s == admin_twitter_id.to_s
  end

end
