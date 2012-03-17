module AdminLeelah::AdminLeelahHelper

  # Check if menu must be display
  def display_menu?
    not in_dash_board?
  end

  # Check if sub-menu must be display and save sub-menu links
  def display_sub_menu?
    @sub_menus = nil

    # sub-menu for Catalog Management
    if controller.is_a?(AdminLeelah::CatalogManagement::CatalogManagementController)
      @sub_menus = {
        '.link.products'    => admin_leelah_catalog_management_products_path,
        '.link.categories'  => admin_leelah_catalog_management_categories_path,
      }
    # sub-menu for Order Management
    elsif controller.is_a?(AdminLeelah::OrderManagement::OrderManagementController)
      @sub_menus = {
        '.link.orders'      => admin_leelah_order_management_orders_path,
      }
    # sub-menu for General Configuration
    elsif controller.is_a?(AdminLeelah::GeneralConfiguration::GeneralConfigurationController)
      @sub_menus = {
        '.link.users'       => admin_leelah_general_configuration_users_path,
      }
    end

    @sub_menus
  end

  # Check if user is displaying Dashboard
  def in_dash_board?
    controller.controller_name == 'dash_board'
  end

end
