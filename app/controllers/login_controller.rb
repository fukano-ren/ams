class LoginController < ApplicationController
  skip_before_action :check_logined
  def index
  end
  
  def auth
    usr = User.authenticate(params[:code],params[:password])
    if usr then
      reset_session
      session[:usr] = usr.id
      session[:name] = usr.name
      session[:system] = usr.system
      session[:admin] = usr.admin
    # redirect_to params[:referer]
      redirect_to controller: 'menu', action: 'index'
    else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザー/パスワードが間違っています。'
      render 'index'
    end
  end
end
