class AdminLeelah::GeneralConfiguration::UsersController < AdminLeelah::GeneralConfiguration::GeneralConfigurationController

  #============================================================================
  #=== FILTERS
  #============================================================================
  before_filter :get_all_users

  #============================================================================
  #=== CRUD for Users -> /admin_leelah/general_configuration/...
  #============================================================================

  # GET users
  # User Panel
  # Show all Users in a table with CRUD actions
  def index

    # hide User form
    @show_form  = false
  end

  # GET users/[:id]
  # :id = User ID
  # Display a User down User Panel
  def show
    @user = User.find(params[:id])

    render :index
  end

  # GET users/new
  # Display a User form down User Panel in orders to create a new User
  def new
    @user = User.new

    render :index
  end

  # POST users
  # Save a User with values in User form for creation
  # if succeed  -> back to User Panel
  # else        -> display form with error
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to admin_leelah_general_configuration_users_path, :notice => t('admin_leelah.general_configuration.users.index.notice.success.create')
    else
      render :index
    end
  end

  # GET users/[:id]/edit
  # :id = User ID
  # Display a User form down User Panel in orders to update an User
  def edit
    @user = User.find(params[:id])

    render :index
  end

  # PUT users/[:id]
  # :id = User ID
  # Update a User with values in User form for update
  # if succeed  -> back to User Panel
  # else        -> display form with error
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to admin_leelah_general_configuration_users_path, :notice => t('admin_leelah.general_configuration.users.index.notice.success.update')
    else
      render :index
    end
  end

  # DELETE users/[:id]
  # :id = User ID
  # Delete a User and redirect to User Panel
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_leelah_general_configuration_users_path, :notice => t('admin_leelah.general_configuration.users.index.notice.success.destroy')
  end

  #============================================================================
  #=== PROTECTED
  #============================================================================
  protected

  # Get all Users in orders to display in Product Panel
  def get_all_users
    @users = User.all

    @show_form  = true
  end

end
