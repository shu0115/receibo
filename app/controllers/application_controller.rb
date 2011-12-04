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
  def authorize
    unless params[:controller] == "sessions"
      if session[:user_id].blank?
        redirect_to login_path
      end
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
