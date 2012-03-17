class AdminLeelah::SessionController < AdminLeelah::AdminLeelahController

  #============================================================================
  #=== FILTERS
  #============================================================================
  skip_before_filter :require_login


  #===========================================================================#
  #===   ACTIONS
  #===========================================================================#

  # GET login
  # Display authentication form
  def login
  end

  # POST authenticate
  def authenticate
    user = User.authenticate(params[:login], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to admin_leelah_root_path, :notice => t('admin_leelah.session.login.notice.login')
    else
      flash.now[:error] = t('admin_leelah.session.login.error.invalid_login')
      render "login"
    end
  end

  # GET logout
  def logout
    @_current_user = session[:user_id] = nil
    redirect_to admin_leelah_login_path, :notice => t('admin_leelah.session.login.notice.logout')
  end

end
