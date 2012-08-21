class Api::UsersController < Api::ApiController

  #===========================================================================#
  #===   FILTERS
  #===========================================================================#
  skip_before_filter :require_token, :only => [:sign_up, :authenticate]



  # Sign up a new user
  #
  # Returns an "+User+" if success to save
  #
  # ====URL:
  # +api/sign_up+
  #
  # ====Method:
  # +POST+
  #
  # ====Body Parameters:
  # * JSON (Content-Type: application/json):
  #     {
  #       "user" : {
  #         "login"     : <string>,   // required
  #         "password"  : <string>,   // required
  #         "email"     : <string>,   // required
  #         "first_name" : <string>,
  #         "last_name"  : <string>,
  #       }
  #     }
  # * HTML form (Content-Type: application/x-www-form-urlencoded)
  #     user[login]=<string>&
  #     user[password]=<string>&
  #     user[email]=<string>&
  #     user[first_name]=<string>&
  #     user[last_name]=<string>
  #
  # ====Result:
  # * "+token+"   if created
  # * "+errors+"  else (array of strings)
  def sign_up
    user = User.new(params[:user])

    if user.save
      response = formatted_response(true, {:token => user.token}, t('api.message.users.sign_up.success'))
    else
      response = formatted_response(false, user.errors, t('api.message.users.sign_up.failure'))
    end

    render :json => response
  end

  # Authenticate an user with login and password
  #
  # Returns an "+User+" if success
  #
  # ====URL:
  # +api/authenticate+
  #
  # ====Method:
  # +POST+
  #
  # ====Body Parameters:
  # * JSON (Content-Type: application/json):
  #     {
  #       "login"     : <value>,   // required
  #       "password"  : <value>    // required
  #     }
  # * HTML form (Content-Type: application/x-www-form-urlencoded)
  #     login=<value>&password=<value>
  #
  # ====Result:
  # * "+user+" if authenticated
  # * "+nil+"   else
  def authenticate
    user = User.authenticate(params[:login], params[:password])

    if user
      response = formatted_response(true, user.as_json(User::JSON_USER_SIMPLE), t('api.message.users.authenticate.success'))
    else
      response = formatted_response(false, nil, ('api.message.users.authenticate.failure'))
    end

    render :json => response
  end

  def index
    users = User.all

    if users
      response = formatted_response(true, {:users => users.as_json(User::JSON_USER_SIMPLE)}, t('api.message.users.index.success'))
    else
      response = formatted_response(false, nil, t('api.message.users.index.failure'))
    end

    render :json => response
  end

  def show
    user = User.find(params[:id])

    if user
      response = formatted_response(true, user.as_json(User::JSON_USER_WITH_ORDERS), t('api.message.users.show.success'))
    else
      response = formatted_response(false, nil, t('api.message.users.show.failure'))
    end

    render :json => response
  end

  def create
    user = User.new(params[:user])

    if user.save
      response = formatted_response(true, user.as_json(User::JSON_USER_SIMPLE), t('api.message.users.create.success'))
    else
      response = formatted_response(false, user.errors, t('api.message.users.create.failure'))
    end

    render :json => response
  end

  def update
    user = User.find(params[:id])

    if user.update_attributes(params[:user])
      response = formatted_response(true, user.as_json(User::JSON_USER_SIMPLE), t('api.message.users.update.success'))
    else
      response = formatted_response(false, user.errors, t('api.message.users.update.failure'))
    end

    render :json => response
  end

  def destroy
    user = User.find(params[:id])

    if user.destroy
      response = formatted_response(true, nil, t('api.message.users.destroy.success'))
    else
      response = formatted_response(false, nil, t('api.message.users.destroy.failure'))
    end

    render :json => response
  end

end
