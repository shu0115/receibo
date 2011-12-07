# coding: utf-8
class ItemsController < ApplicationController

  #-----#
  # top #
  #-----#
  def top
    render :layout => false
  end
  
  #-----#
  # add #
  #-----#
  def add
    @item = Item.new

    @items = Item.where( :user_id => session[:user_id] )
    @items = @items.where( "created_at >= '#{Time.now.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at <= '#{Time.now.end_of_day.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @today_sum = @items.sum( :price )
    @items = @items.order( "created_at DESC" ).all

    @this_month_sum = Item.where( :user_id => session[:user_id] )
    @this_month_sum = @this_month_sum.where( "created_at >= '#{Time.now.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at < '#{Time.now.months_since(1).beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @this_month_sum = @this_month_sum.sum( :price )
    
    @now = Time.now
#    @wdays = ["日", "月", "火", "水", "木", "金", "土"]
    
    render :layout => false
  end

  #--------#
  # create #
  #--------#
  def create
    print "[ params ] : " ; p params ;
    
    @item = Item.new( params[:item] )
    
    unless params[:date].blank?
      @item.created_at = Time.parse( params[:date] )
    else
      @item.created_at = Time.now
    end

    unless @item.blank?
      @item.user_id = session[:user_id]

      unless @item.save
        flash[:notice] = "項目の作成に失敗しました。"
      end
    else
      flash[:notice] = "登録する情報がありません。"
    end

    from = params[:from]
    from = "add" if from.blank?
    redirect_to :action => from, :date => params[:date]
  end

  #-----#
  # day #
  #-----#
  def day
    @item = Item.new

    unless params[:date].blank?
      @this_day = Time.parse( params[:date] )
    else
      @this_day = Time.now
    end
print "[ @this_day ] : " ; p @this_day ;
    @items = Item.where( :user_id => session[:user_id] )
    @items = @items.where( "created_at >= '#{@this_day.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at <= '#{@this_day.end_of_day.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @today_sum = @items.sum( :price )
    @items = @items.order( "created_at DESC" ).all

    @this_month_sum = Item.where( :user_id => session[:user_id] )
    @this_month_sum = @this_month_sum.where( "created_at >= '#{@this_day.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at < '#{@this_day.months_since(1).beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @this_month_sum = @this_month_sum.sum( :price )

    @now = Time.now
    
    render :layout => false
  end

  #-------#
  # month #
  #-------#
  def month
    @items = Item.where( :user_id => session[:user_id] )
    @items = @items.where( "created_at >= '#{Time.now.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at <= '#{Time.now.months_since(1).end_of_month.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @this_month_sum = @items.sum( :price )
    @items = @items.order( "created_at DESC" ).all

    @this_year_sum = Item.where( :user_id => session[:user_id] )
    @this_year_sum = @this_year_sum.where( "created_at >= '#{Time.now.beginning_of_year.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at < '#{Time.now.years_since(1).beginning_of_year.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @this_year_sum = @this_year_sum.sum( :price )

    @this_month_sum = Item.where( :user_id => session[:user_id] )
    @this_month_sum = @this_month_sum.where( "created_at >= '#{Time.now.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at < '#{Time.now.months_since(1).beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @this_month_sum = @this_month_sum.sum( :price )

    @day_sum_array = Array.new
    1.upto(Time.now.end_of_month.day){ |day|
      month_day = Time.local(Time.now.year, Time.now.month, day, 0, 0, 0)
      day_sum = Item.where( :user_id => session[:user_id] )
      day_sum = day_sum.where( "created_at >= '#{month_day.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at < '#{month_day.end_of_day.strftime("%Y-%m-%d %H:%M:%S")}'" )
      day_sum = day_sum.sum( :price )
      @day_sum_array[day] = day_sum
    }

    @now = Time.now
    
    render :layout => false
  end

  #------#
  # year #
  #------#
  def year
  end

  #------#
  # edit #
  #------#
  def edit
    @item = Item.find( params[:id] )
    
    @items = Item.where( :user_id => session[:user_id] )
    @items = @items.where( "created_at >= '#{@item.created_at.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at <= '#{@item.created_at.end_of_day.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @today_sum = @items.sum( :price )
    @items = @items.order( "created_at DESC" ).all
    
    @this_day = @item.created_at
  end

  #--------#
  # update #
  #--------#
  def update
    @item = Item.where( :user_id => session[:user_id], :id => params[:id] ).first

    unless @item.update_attributes( params[:item] )
      flash[:notice] = "更新に失敗しました。"
    end

    redirect_to :action => "edit", :id => @item.id
  end

  #--------#
  # delete #
  #--------#
  def delete
    @item = Item.where( :user_id => session[:user_id], :id => params[:id] ).first
    @item.destroy

    redirect_to :action => "day", :date => @item.created_at
  end



  # ----- 参考(リリース前に消す) ----- #
  
  #------#
  # add2 #
  #------#
  def add2
    @item = Item.new

    @items = Item.where( :user_id => session[:user_id] )
    @items = @items.where( "created_at >= '#{Time.now.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at <= '#{Time.now.end_of_day.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @today_sum = @items.sum( :price )
    @items = @items.order( "created_at DESC" ).all

    @this_month_sum = Item.where( :user_id => session[:user_id] )
    @this_month_sum = @this_month_sum.where( "created_at >= '#{Time.now.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}' AND created_at < '#{Time.now.months_since(1).beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}'" )
    @this_month_sum = @this_month_sum.sum( :price )
    
    @now = Time.now
    @wdays = ["日", "月", "火", "水", "木", "金", "土"]
    
    render :layout => false
  end

  #---------#
  # create2 #
  #---------#
  def create2
    @item = Item.new(params[:item])

    unless @item.blank?
      @item.user_id = session[:user_id]

      unless @item.save
        flash[:notice] = "項目の作成に失敗しました。"
      end
    else
      flash[:notice] = "登録する情報がありません。"
    end

    redirect_to :action => "add"
  end

end
