class OrderController < ApplicationController
  def index
    @orders = Order.last(10).reverse
  end

  def last
    orders = Order.last(10).reverse

    render :json => orders
  end
end
