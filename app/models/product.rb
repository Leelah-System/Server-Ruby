class Product < ActiveRecord::Base

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  belongs_to  :category
  has_many    :order_lines
  has_one     :picture, :as => :imageable

  accepts_nested_attributes_for :category,  :picture

  #===========================================================================#
  #===   VALIDATIONS
  #===========================================================================#
  validates_presence_of     :name, :price, :stock, :reference
  validates_numericality_of :price, :stock, :greater_than_or_equal_to => 0

  #===========================================================================#
  #===   CALLBACKS
  #===========================================================================#

  #===========================================================================#
  #===   PUBLIC
  #===========================================================================#

  def as_json(options={})
    super(
        :include => {
          :category => {
            :except => [:created_at, :updated_at]
          },
          :picture => {
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


end
