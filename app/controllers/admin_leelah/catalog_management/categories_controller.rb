class AdminLeelah::CatalogManagement::CategoriesController < AdminLeelah::CatalogManagement::CatalogManagementController

  #============================================================================
  #=== FILTERS
  #============================================================================
  before_filter :get_all_categories

  #============================================================================
  #=== CRUD for Categories -> /admin_leelah/catalog_management/...
  #============================================================================

  # GET categories
  # Category Panel
  # Show all Categories in a table with CRUD actions
  def index

    # hide Category form
    @show_form  = false
  end

  # GET categories/[:id]
  # :id = Category ID
  # Display a Category down Category Panel
  def show
    @category = Category.find(params[:id])

    render :index
  end

  # GET categories/new
  # Display a Category form down Category Panel in orders to create a new Category
  def new
    @category = Category.new

    render :index
  end

  # POST categories
  # Save a Category with values in Category form for creation
  # if succeed  -> back to Category Panel
  # else        -> display form with error
  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to admin_leelah_catalog_management_categories_path, :notice => t('admin_leelah.catalog_management.categories.index.notice.success.create')
    else
      render :index
    end
  end

  # GET categories/[:id]/edit
  # :id = Category ID
  # Display a Category form down Category Panel in orders to update a Category
  def edit
    @category = Category.find(params[:id])

    render :index
  end

  # PUT categories/[:id]
  # :id = Category ID
  # Update a Category with values in Category form for update
  # if succeed  -> back to Category Panel
  # else        -> display form with error
  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to admin_leelah_catalog_management_categories_path, :notice => t('admin_leelah.catalog_management.categories.index.notice.success.update')
    else
      render :index
    end
  end

  # DELETE categories/[:id]
  # :id = Category ID
  # Delete a Category and redirect to Category Panel
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to admin_leelah_catalog_management_categories_path, :notice => t('admin_leelah.catalog_management.categories.index.notice.success.destroy')
  end

  #============================================================================
  #=== PROTECTED
  #============================================================================
  protected

  # Get all Categories in orders to display in Category Panel
  def get_all_categories
    @categories = Category.all

    @show_form  = true
  end

end
