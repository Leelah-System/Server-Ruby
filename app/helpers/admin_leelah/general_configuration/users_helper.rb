module AdminLeelah::GeneralConfiguration::UsersHelper

  def show_user?
    controller_name == 'users' and action_name == 'show'
  end

end
