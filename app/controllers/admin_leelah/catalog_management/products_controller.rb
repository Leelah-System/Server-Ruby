class AdminLeelah::CatalogManagement::ProductsController < AdminLeelah::CatalogManagement::CatalogManagementController

  #============================================================================
  #=== FILTERS
  #============================================================================
  before_filter :get_all_products

  #============================================================================
  #=== CRUD for Products -> /admin_leelah/catalog_management/...
  #============================================================================

  # GET products
  # Product Panel
  # Show all Products in a table with CRUD actions
  def index

    # hide Product form
    @show_form  = false
  end

  # GET products/[:id]
  # :id = Product ID
  # Display a Product down Product Panel
  def show
    @product = Product.find(params[:id])

    render :index
  end

  # GET products/new
  # Display a Product form down Product Panel in orders to create a new Product
  def new
    @product = Product.new

    render :index
  end

  # POST products
  # Save a Product with values in Product form for creation
  # if succeed  -> back to Product Panel
  # else        -> display form with error
  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to admin_leelah_catalog_management_products_path, :notice => t('admin_leelah.catalog_management.products.index.notice.success.create')
    else
      render :index
    end
  end

  # GET products/[:id]/edit
  # :id = Product ID
  # Display a Product form down Product Panel in orders to update a Product
  def edit
    @product = Product.find(params[:id])

    render :index
  end

  # PUT products/[:id]
  # :id = Product ID
  # Update a Product with values in Product form for update
  # if succeed  -> back to Product Panel
  # else        -> display form with error
  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_leelah_catalog_management_products_path, :notice => t('admin_leelah.catalog_management.products.index.notice.success.update')
    else
      render :index
    end
  end

  # DELETE products/[:id]
  # :id = Product ID
  # Delete a Product and redirect to Product Panel
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to admin_leelah_catalog_management_products_path, :notice => t('admin_leelah.catalog_management.products.index.notice.success.destroy')
  end

  #============================================================================
  #=== PROTECTED
  #============================================================================
  protected

  # Get all Products in orders to display in Product Panel
  def get_all_products
    @products = Product.all

    @show_form  = true
  end

end
