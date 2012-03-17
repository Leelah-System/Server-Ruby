class Product < ActiveRecord::Base

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  belongs_to  :category
  has_many    :order_lines

  #===========================================================================#
  #===   VALIDATIONS
  #===========================================================================#
  validates_presence_of     :name, :price, :stock, :reference
  validates_numericality_of :price, :stock, :greater_than_or_equal_to => 0

  #===========================================================================#
  #===   CALLBACKS
  #===========================================================================#
  before_validation :create_reference

  #===========================================================================#
  #===   PUBLIC
  #===========================================================================#

  def as_json(options={})
    super(
        :include => {
          :category => {
            :except => [:created_at, :updated_at]
          }
        },
        :except => [:logo_id, :created_at, :updated_at]
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
