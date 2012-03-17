module AdminLeelah::CatalogManagement::ProductsHelper

  def show_product?
    controller_name == 'products' and action_name == 'show'
  end

end
