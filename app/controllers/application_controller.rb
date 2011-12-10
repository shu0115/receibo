# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  # 未ログインリダイレクト
  before_filter :authorize

  # httpsリダイレクト
  before_filter :ssl_redirect

  # BASIC認証
  before_filter :password_protected if Rails.env.staging?

  protected

  #--------------------#
  # password_protected #
  #--------------------#
  # BASIC認証
  def password_protected
    authenticate_or_request_with_http_basic do |username, password|
      username == "receibo" && password == "receibo1204"
    end
  end

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
