class Api::OrdersController < Api::ApiController

  # Get list of all Orders
  #
  # ====URL:
  # +/api/:token/orders+
  #
  # ====Method:
  # +GET+
  #
  # ====Result:
  # * "+collection of Orders+"
  def index
    orders = Order.all

    if orders
      response = formatted_response(true, {:orders => orders}, t('api.message.orders.index.success'))
    else
      response = formatted_response(false, nil, t('api.message.orders.index.failure'))
    end

    render :json => response
  end

end
