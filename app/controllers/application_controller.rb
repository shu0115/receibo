# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  # 未ログインリダイレクト
  before_filter :authorize

  # httpsリダイレクト
  before_filter :ssl_redirect

  private
  #-----------#
  # authorize #
  #-----------#
  # ログイン認証
  def authorize
    if (params[:controller] == "items" and params[:action] == "top") and params[:controller] != "sessions"
      # トップページでログイン済みであればaddへリダイレクト
      redirect_to :controller => "items", :action => "add" unless session[:user_id].blank?
    elsif params[:controller] != "sessions"
      # トップページ以外で未ログインであればトップヘリダイレクト
      redirect_to :root if session[:user_id].blank?
    end
  end

  #--------------#
  # ssl_redirect #
  #--------------#
  def ssl_redirect
    # httpsへリダイレクト(production環境のみ)
    if Rails.env.production? and request.env["HTTP_X_FORWARDED_PROTO"].to_s != "https"
      request.env["HTTP_X_FORWARDED_PROTO"] = "https"
      redirect_to request.url and return
    end
  end

end
