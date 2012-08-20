class Api::OrdersController < Api::ApiController

  # Get list of all Orders
  #
  # ====URL:
  # +/api/:token/order/orders+
  #
  # ====Method:
  # +GET+
  #
  # ====Result:
  # * "+collection of Orders+"
  def index
    orders = Order.with_products_and_user

    if orders
      response = formatted_response(true, {:orders => orders}, t('api.message.orders.index.success'))
    else
      response = formatted_response(false, nil, t('api.message.orders.index.failure'))
    end

    render :json => response
  end

  def show
    order = Order.with_products_and_user.find(params[:id])

    if order
      response = formatted_response(true, order, t('api.message.orders.show.success'))
    else
      response = formatted_response(false, nil, t('api.message.orders.show.failure'))
    end

    render :json => response
  end

  def create
    order = Order.new(params[:order])
    order.user = current_user

    if order.save
      response = formatted_response(true, order, t('api.message.orders.create.success'))
    else
      response = formatted_response(false, order.errors, t('api.message.orders.create.failure'))
    end

    render :json => response
  end

  def update
    order = Order.with_products_and_user.find(params[:id])
    order.user = current_user

    if order.update_attributes(params[:order])
      response = formatted_response(true, order, t('api.message.orders.update.success'))
    else
      response = formatted_response(false, order.errors, t('api.message.orders.update.failure'))
    end

    render :json => response
  end

  def destroy
    order = Order.find(params[:id])

    if order.destroy
      response = formatted_response(true, nil, t('api.message.orders.destroy.success'))
    else
      response = formatted_response(false, nil, t('api.message.orders.destroy.failure'))
    end

    render :json => response
  end

end
