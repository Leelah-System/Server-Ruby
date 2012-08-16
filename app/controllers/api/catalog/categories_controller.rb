class Api::Catalog::CategoriesController < Api::ApiController

  # Get list of all Categories
  #
  # ====URL:
  # +/api/:token/catalog/categories+
  #
  # ====Method:
  # +GET+
  #
  # ====Result:
  # * "+collection of Categories+"
  def index
    categories = Category.joins(:products).includes(:products).all

    if categories
      response = formatted_response(true, {:categories => categories}, t('api.message.catalog.categories.index.success'))
    else
      response = formatted_response(false, nil, t('api.message.catalog.categories.index.failure'))
    end

    render :json => response
  end

  # Get a Category
  #
  # ====URL:
  # +/api/:token/catalog/categories/:id+
  #
  # ====Method:
  # +GET+
  #
  # ====Parameters:
  # * Category ID
  #
  # ====Result:
  # * "+Category+"
  def show
    category = Category.joins(:products).find(params[:id])

    if category
      response = formatted_response(true, category, t('api.message.catalog.categories.show.success'))
    else
      response = formatted_response(false, nil, t('api.message.catalog.categories.show.failure'))
    end

    render :json => response
  end

  # Create a Category
  #
  # ====URL:
  # +/api/:token/catalog/categories+
  #
  # ====Method:
  # +POST+
  #
  # ====Body Parameters:
  # TODO parametres creation Category via API
  #
  # ====Result:
  # * "+Category+" created
  def create
    category = Category.new(params[:category])

    if category.save
      response = formatted_response(true, category, t('api.message.catalog.categories.create.success'))
    else
      response = formatted_response(false, category.errors, t('api.message.catalog.categories.create.failure'))
    end

    render :json => response
  end

  # Update a Category
  #
  # ====URL:
  # +/api/:token/catalog/categories/:id+
  #
  # ====Method:
  # +PUT+
  #
  # ====Parameters:
  # * Category ID
  #
  # ====Body Parameters:
  # TODO parametres update Category via API
  #
  # ====Result:
  # * "+Category+" updated
  def update
    category = Category.find(params[:id])

    if category.update_attributes(params[:category])
      response = formatted_response(true, category, t('api.message.catalog.categories.update.success'))
    else
      response = formatted_response(false, category.errors, t('api.message.catalog.categories.update.failure'))
    end

    render :json => response
  end

  # Destroy a Category
  #
  # ====URL:
  # +/api/:token/catalog/categories/:id+
  #
  # ====Method:
  # +DELETE+
  #
  # ====Parameters:
  # * Category ID
  #
  # ====Result:
  # * "+nil+" with confirmation message
  def destroy
    category = Category.find(params[:id])

    if category.destroy
      response = formatted_response(true, nil, t('api.message.catalog.categories.destroy.success'))
    else
      response = formatted_response(false, nil, t('api.message.catalog.categories.destroy.failure'))
    end

    render :json => response
  end

end
