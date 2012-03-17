class AdminLeelah::AdminLeelahController < ApplicationController
  protect_from_forgery

  #============================================================================
  #=== FILTERS
  #============================================================================
  before_filter :require_login, :allow_only_html
  
  #============================================================================
  #=== PROTECTED
  #============================================================================
  protected

  # Give current user id
  def current_user
    @_current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  # Check if user is logged
  def logged_in?
    current_user
  end

  # Callback uses to check if user is log in
  def require_login
    unless logged_in?
      redirect_to admin_leelah_login_path
    end
  end

  def allow_only_html
    if params[:format] and params[:format] != "html"
      render :file => 'public/404.html', :status => 404, :layout => false
    end
  end

end