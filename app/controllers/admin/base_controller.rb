class Admin::BaseController < ApplicationController
  protect_from_forgery with: :exception

  layout 'application'

  before_action :_authenticate_user!

  helper_method :_current_user
  helper_method :_sign_out_path

  def _authenticate_user!
    if !current_user
      session[:return_to] = request.fullpath
      redirect_to Rails.application.routes.url_helpers.login_path
      false
    end
  end


  def _current_user
    begin
      @current_user ||= User.where(can_login: true).find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      session[:user_id]   = nil
      @current_user       = nil
    end
  end


  def _sign_out_path
    Rails.application.routes.url_helpers.logout_path
  end


  private

  def authorize_admin
    unless current_user.try(:is_admin?)
      flash[:error] = "You must be a superuser to do that."
      redirect_to root_path and return false
    end
  end
end
