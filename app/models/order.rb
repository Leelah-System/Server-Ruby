class Order < ActiveRecord::Base

  #===========================================================================#
  #===   STATUS
  #===========================================================================#
  class OrderStatus
    attr_reader :id, :name

    def initialize(id, name)
      @id, @name  = id, name
    end
  end

  STATUS_INITIALIZED  = 0
  STATUS_PENDING      = 1
  STATUS_COMPLETED    = 2

  STATUS_LIST = [
      OrderStatus.new(STATUS_INITIALIZED,   I18n.t('.order.status.initialized')),
      OrderStatus.new(STATUS_PENDING,       I18n.t('.order.status.pending')),
      OrderStatus.new(STATUS_COMPLETED,     I18n.t('.order.status.completed')),
  ]

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  belongs_to  :user
  has_many    :order_lines

  accepts_nested_attributes_for :order_lines

  #===========================================================================#
  #===   SCOPES
  #===========================================================================#
  scope :with_products_and_user,  includes(:user, :order_lines => [:product])

  scope :with_status,             lambda { |status| where(:status => status)  }

  #===========================================================================#
  #===   CALLBACKS
  #===========================================================================#
  before_validation :create_reference, :remove_duplicate_products, :calculate_amount

  #===========================================================================#
  #===   PUBLIC
  #===========================================================================#
  attr_readonly :nb_products, :status_to_string

  def nb_products
    @nb_products = 0

    self.order_lines.each do |order_line|
      @nb_products = @nb_products + order_line.quantity
    end

    @nb_products
  end

  def status_to_string
    STATUS_LIST[self.status].name if self.status
  end

  JSON_WITH_USER_AND_PRODUCTS = {
      :include => {
        :user => {
          :methods  => [:name, :status_to_string],
          :except => [:password, :salt, :token, :created_at, :updated_at]
        },
        :order_lines => {
          :include => {
              :product => {
                :except => [:logo_id, :created_at, :updated_at]
              }
          },
        }
      },
      :methods => [:status_to_string]
  }

  def as_json(options={})
    super(JSON_WITH_USER_AND_PRODUCTS)
  end

  #===========================================================================#
  #===   PROTECTED
  #===========================================================================#
  protected

  def create_reference
    lastOrder = Order.last
    now = Time.new
    day_now = "%05d" % now.yday

    if lastOrder
      split_ref = lastOrder.reference.split("-")
      # same day
      if split_ref[1] == day_now
        last_num = split_ref[2].to_i
        last_num += 1
        self.reference = "%05d" % now.year + "-" + day_now + "-" + "%05d" % last_num
      # new day
      else
        self.reference = "%05d" % now.year + "-" + day_now + "-" + "%05d" % 1
      end
    else
      # first order
      self.reference = "%05d" % now.year + "-" + day_now + "-" + "%05d" % 1
    end

    puts self.reference

  end

  def remove_duplicate_products

    # hash "product_id" => index de order_line dans "order.order_lines"
    product_ids = {}

    self.order_lines.each_with_index do |order_line, index|

      # si l'ID du product existe dans "products_ids"
      # on garde la dernière quantité et on supprime une des order_lines
      if product_ids[order_line.product_id]

        # récupèration de l'order_line contenant le "product" en double
        i = product_ids[order_line.product_id]
        existing_order_line = self.order_lines[i]

        # on garde la dernière quantité
        existing_order_line.quantity = order_line.quantity

        # suppression l'order_line en doublon
        self.order_lines.delete_at(index)

      # si l'ID du product n'existe pas
      else
        product_ids[order_line.product_id] = index
      end

    end

  end

  def calculate_amount

    self.amount = 0
    self.order_lines.each do |order_line|

      order_line.amount = order_line.quantity * order_line.product.price

      self.amount += order_line.amount

    end
  end

end
