class AdminLeelah::OrderManagement::OrdersController < AdminLeelah::OrderManagement::OrderManagementController

  #============================================================================
  #=== FILTERS
  #============================================================================
  before_filter :get_all_orders

  #============================================================================
  #=== Panel for Orders -> /admin_leelah/order_management/...
  #============================================================================

  # GET orders
  # Order Panel
  # Show all Order in a table with actions
  def index
    @show_detail = false
  end

  # GET orders/[:id]
  # :id = Order ID
  # Display Order details down Order Panel
  def show
    @order = Order.find(params[:id])

    render :index
  end

  #============================================================================
  #=== PROTECTED
  #============================================================================
  protected

  # Get all Orders in orders to display in Order Panel
  def get_all_orders
    @orders = Order.all

    @show_detail = true
  end

end
