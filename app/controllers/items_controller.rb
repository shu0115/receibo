# coding: utf-8
class ItemsController < ApplicationController

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
    @wdays = ["日", "月", "火", "水", "木", "金", "土"]
    
    render :layout => false
  end

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

  #--------#
  # create #
  #--------#
  def create
    print "[ params ] : " ; p params ;
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
    1.upto

    @now = Time.now
    @wdays = ["日", "月", "火", "水", "木", "金", "土"]
    
    render :layout => false
  end



=begin
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
=end

end
