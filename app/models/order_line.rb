class OrderLine < ActiveRecord::Base

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  belongs_to :order
  belongs_to :product

end
