# coding: utf-8
class SessionsController < ApplicationController
  unloadable

  def new
    if TwitterAuth.oauth?
      oauth_callback = request.protocol + request.host_with_port + '/oauth_callback'
      puts "[ ---------- oauth_callback ---------- ]" ; oauth_callback.tapp ;
      @request_token = TwitterAuth.consumer.get_request_token({:oauth_callback=>oauth_callback})
      puts "[ ---------- @request_token ---------- ]" ; @request_token.tapp ;
      session[:request_token] = @request_token.token
      session[:request_token_secret] = @request_token.secret

      puts "[ ---------- session[:request_token] ---------- ]" ; session[:request_token].tapp ;
      puts "[ ---------- session[:request_token_secret] ---------- ]" ; session[:request_token_secret].tapp ;

      'https://api.twitter.com/oauth/authenticate'
      url = @request_token.authorize_url
      url << "&oauth_callback=#{CGI.escape(TwitterAuth.oauth_callback)}" if TwitterAuth.oauth_callback?
      puts "[ ---------- url ---------- ]" ; url.tapp ;
      url.gsub!('https://api.twitter.com/1.1/oauth/authenticate', 'https://api.twitter.com/oauth/authenticate')
      puts "[ ---------- url ---------- ]" ; url.tapp ;

      redirect_to url
    else
      puts "[ ---------- we don't have to do anything, it's just a simple form for HTTP basic! ---------- ]"
      # we don't have to do anything, it's just a simple form for HTTP basic!
    end
  end

  def create
    logout_keeping_session!
    if user = User.authenticate(params[:login], params[:password])
      self.current_user = user
      authentication_succeeded and return
    else
      authentication_failed('Unable to verify your credentials through Twitter. Please try again.', '/login') and return
    end
  end

  def oauth_callback
    print "[ params ] : " ; p params ;
    unless session[:request_token] && session[:request_token_secret]
      authentication_failed('No authentication information was found in the session. Please try again.') and return
    end

   unless params[:oauth_token].blank? || session[:request_token] ==  params[:oauth_token]
     authentication_failed('Authentication information does not match session information. Please try again.') and return
   end

    @request_token = OAuth::RequestToken.new(TwitterAuth.consumer, session[:request_token], session[:request_token_secret])

    oauth_verifier = params["oauth_verifier"]
    @access_token = @request_token.get_access_token(:oauth_verifier => oauth_verifier)

    # The request token has been invalidated
    # so we nullify it in the session.
    session[:request_token] = nil
    session[:request_token_secret] = nil

    print "[ @access_token ] : " ; p @access_token ;

    @user = User.identify_or_create_from_access_token(@access_token)

    session[:user_id] = @user.id

    self.remember_token = @user.remember_me

    authentication_succeeded
  rescue Net::HTTPServerException => e
    puts "[ ---------- Net::HTTPServerException e ---------- ]" ; e.tapp ;
    case e.message
      when '401 "Unauthorized"'
        authentication_failed('This authentication request is no longer valid. Please try again.') and return
      else
        authentication_failed('There was a problem trying to authenticate you. Please try again.') and return
    end
  # OAuth Unauthorized Rescue Add
  rescue OAuth::Unauthorized => e
    puts "[ ---------- OAuth::Unauthorized e ---------- ]" ; e.tapp ;
    authentication_failed(t('This authentication request is no longer valid Please try again')) and return
  end

  def destroy
    logout_keeping_session!
    redirect_back_or_default('/')
  end
end
