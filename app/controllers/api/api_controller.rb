class Api::ApiController < ApplicationController

  #===========================================================================#
  #===   FILTERS
  #===========================================================================#
  before_filter :require_token, :allow_only_json


  #===========================================================================#
  #===   PROTECTED
  #===========================================================================#
  protected

  def allow_only_json
    if params[:format] and params[:format] != "json"
      respond_to do |format|
        format.json { render :json => formatted_response(false, nil, t('api.request.not_found')), :status => :not_found }
        format.xml  { render :xml => formatted_response(false, nil, t('api.request.not_found')), :status => :not_found }
      end
    end
  end

  # Give current user id
  def current_user
    @_current_user
  end

  # Check if "+token+" is provide and correspond to an user
  #
  # Display an error response if "+token+" doesn't match to any user
  #
  # Call by "+before_filter+" callback
  def require_token
    user = User.find_by_token(params[:token])
    if user
      @_current_user = user.id
    else
      respond_to do |format|
        format.json { render :json => formatted_response(false, nil, t('api.request.unauthorized')), :status => :unauthorized }
        format.xml { render :xml => formatted_response(false, nil, t('api.request.unauthorized')), :status => :unauthorized }
      end
    end
  end

  # Returns a formatted response for API
  #
  # ====Parameters:
  #   "success" => if request succeed (true or false)
  #   "result"  => result of the request (any type)
  #   "msg"     => message for the response (string or nil)
  def formatted_response(success, result, msg)
    {:success => success, :result => result, :msg => msg}
  end

end
