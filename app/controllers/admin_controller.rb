# coding: utf-8
class AdminController < ApplicationController

  # 管理者以外リダイレクト
  before_filter :admin_authorize

  #-------#
  # users #
  #-------#
  def users
    limit_set = params[:limit].presence || 500
    @users = User.includes( :item ).order( "id DESC" ).limit( limit_set ).all
    @item_count = Item.count
    @users_count = User.count
  end
  
  #-------#
  # count #
  #-------#
  def count
    limit_set = params[:limit].presence || 500
    @item_count = Item.count
    @users_count = User.count

    @users = User.joins( :item ).select( 'count(*) as item_count, users.id' ).group( 'users.id' ).order( "item_count DESC" ).limit( limit_set ).all
  end
  
  #------#
  # days #
  #------#
  def days
    @item_count = Item.count
    @users_count = User.count
    
    @days_count_hash = Hash.new
    @first_day = Item.order( "buy_date ASC" ).select( "buy_date" ).first
    @last_day = Item.order( "buy_date DESC" ).select( "buy_date" ).first
    @now_day = @first_day.buy_date

    while @now_day <= @last_day.buy_date
      @days_count_hash[@now_day.strftime("%Y%m%d")] = Hash.new
      @days_count_hash[@now_day.strftime("%Y%m%d")][:day] = @now_day
      @days_count_hash[@now_day.strftime("%Y%m%d")][:count] = Item.where( "buy_date >= '#{@now_day.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")}' AND buy_date <= '#{@now_day.end_of_day.strftime("%Y-%m-%d %H:%M:%S")}'" ).count
      @now_day = @now_day.since( 1.day )
    end
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
