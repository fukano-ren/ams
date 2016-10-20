class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_logined
  private
  def check_logined
    if session[:usr] then
      begin
        @usr = User.find(session[:usr])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    unless @usr
      flash[:referer] = request.fullpath
      redirect_to controller: :login, action: :index
    end
  end
  def log_out
    session.delete(:user.id)
    @session[:usr] = nil
    @session[:usrname]
  end
end
