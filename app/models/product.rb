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
  #===   SCOPES
  #===========================================================================#
  scope :with_category_and_picture, includes(:category, :picture)

  # Stocks
  scope :with_stock,                where("products.stock > 0")
  scope :without_stock,             where("products.stock <= 0")

  # Search text
  scope :search_text,               lambda { |text| where("reference like ? or label like ? or name like ? or description like ?",
                                                          "%#{text}%", "%#{text}%", "%#{text}%", "%#{text}%")  }
  scope :search_reference,          lambda { |text| where("reference like ?", "%#{text}%")  }
  scope :search_label,              lambda { |text| where("label like ?", "%#{text}%")  }
  scope :search_name,               lambda { |text| where("name like ?", "%#{text}%")  }
  scope :search_description,        lambda { |text| where("description like ?", "%#{text}%")  }

  # Search prices
  scope :price_max,                 lambda { |max_price| where("price <= ?", max_price)  }
  scope :price_min,                 lambda { |min_price| where("price >= ?", min_price)  }
  scope :price_between,             lambda { |min_price, max_price| where("price >= ? and price <= ?", min_price, max_price)}

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
