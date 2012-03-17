module AdminLeelah::CatalogManagement::CategoriesHelper

  def show_category?
    controller_name == 'categories' and action_name == 'show'
  end

end
