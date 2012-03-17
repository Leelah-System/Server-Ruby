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
      OrderStatus.new(STATUS_INITIALIZED,   I18n.t('.orders.status.initialized')),
      OrderStatus.new(STATUS_PENDING,       I18n.t('.orders.status.pending')),
      OrderStatus.new(STATUS_COMPLETED,     I18n.t('.orders.status.completed')),
  ]

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  belongs_to  :user
  has_many    :order_lines

  accepts_nested_attributes_for :order_lines

  #===========================================================================#
  #===   CALLBACKS
  #===========================================================================#
  before_validation :create_reference

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
    STATUS_LIST[self.status].name
  end

  def as_json(options={})
    super(
        :include => {
          :order_lines => {
            :include => {
                :product => {
                  :except => [:logo_id, :created_at, :updated_at, :category_id]
                }
            },
            :except => [:created_at, :updated_at]
          }
        }
    )
  end

  #===========================================================================#
  #===   PROTECTED
  #===========================================================================#
  protected

  def create_reference
    self.reference = SecureRandom.random_number(1000000)
  end

end
