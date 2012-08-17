class Api::Catalog::ProductsController < Api::ApiController

  # Get list of all Products
  #
  # ====URL:
  # +/api/:token/catalog/products+
  #
  # ====Method:
  # +GET+
  #
  # ====Result:
  # * "+collection of Products+"
  def index

    products, errors = get_products_with_request

    if products && errors.empty?
      response = formatted_response(true, {:products => products}, t('api.message.catalog.products.index.success'))
    else
      response = formatted_response(false, {:errors => errors}, t('api.message.catalog.products.index.failure'))
    end

    render :json => response
  end


  # Get a Product
  #
  # ====URL:
  # +/api/:token/catalog/products/:id+
  #
  # ====Method:
  # +GET+
  #
  # ====Parameters:
  # * Product ID
  #
  # ====Result:
  # * "+Product+"
  def show
    product = Product.includes(:category, :picture).find(params[:id])

    if product
      response = formatted_response(true, product, t('api.message.catalog.products.show.success'))
    else
      response = formatted_response(false, nil, t('api.message.catalog.products.show.failure'))
    end

    render :json => response
  end

  # Create a Product
  #
  # ====URL:
  # +/api/:token/catalog/products+
  #
  # ====Method:
  # +POST+
  #
  # ====Body Parameters:
  # TODO parametres creation Product via API
  #
  # ====Result:
  # * "+Product+" created
  def create
    product = Product.new(params[:product])

    if product.save
      response = formatted_response(true, product, t('api.message.catalog.products.create.success'))
    else
      response = formatted_response(false, product.errors, t('api.message.catalog.products.create.failure'))
    end

    render :json => response
  end

  # Update a Product
  #
  # ====URL:
  # +/api/:token/catalog/products/:id+
  #
  # ====Method:
  # +PUT+
  #
  # ====Parameters:
  # * Product ID
  #
  # ====Body Parameters:
  # TODO parametres update Product via API
  #
  # ====Result:
  # * "+Product+" updated
  def update
    product = Product.find(params[:id])

    if product.update_attributes(params[:product])
      response = formatted_response(true, product, t('api.message.catalog.products.update.success'))
    else
      response = formatted_response(false, product.errors, t('api.message.catalog.products.update.failure'))
    end

    render :json => response
  end

  # Destroy a Product
  #
  # ====URL:
  # +/api/:token/catalog/products/:id+
  #
  # ====Method:
  # +DELETE+
  #
  # ====Parameters:
  # * Product ID
  #
  # ====Result:
  # * "+nil+" with confirmation message
  def destroy
    product = Product.find(params[:id])

    if product.destroy
      response = formatted_response(true, nil, t('api.message.catalog.products.destroy.success'))
    else
      response = formatted_response(false, nil, t('api.message.catalog.products.destroy.failure'))
    end

    render :json => response
  end

  protected

  def get_products_with_request
    errors = []

    # test si un "scope" est passé en paramètres
    if defined? params[:scope] then
      begin
        scope = params[:scope]

        # recherche par rapport à un texte
        if scope =~ /search_(.*)/
          text = params[:text]
          if text
            products = Product.send(scope, text).with_category_and_picture
          else
            errors << t('api.message.catalog.products.index.errors.no_text')
          end

        # recherche par rapport au prix
        elsif scope == "price"
          min_price = params[:min_price]
          max_price = params[:max_price]

          if min_price and max_price
            products = Product.price_between(min_price, max_price).with_category_and_picture
          elsif min_price
            products = Product.price_min(min_price).with_category_and_picture
          elsif max_price
            products = Product.price_max(max_price).with_category_and_picture
          else
            errors << t('api.message.catalog.products.index.errors.no_price')
          end

        end

      # "scope" non trouvé
      rescue NoMethodError => e
        errors << e.to_s.split(" for")[0]

      # erreur générique
      rescue Exception => e
        errors << e.to_s
      end

    # sans "scope" => tous les produits
    else
      products = Product.with_category_and_picture
    end

    return products, errors
  end

end
