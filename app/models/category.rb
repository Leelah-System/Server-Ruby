class Category < ActiveRecord::Base

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  has_many  :products
  has_one   :picture, :as => :imageable

  accepts_nested_attributes_for :picture

  #===========================================================================#
  #===   VALIDATIONS
  #===========================================================================#
  validates_presence_of     :name, :description

  #===========================================================================#
  #===   PUBLIC
  #===========================================================================#

  def as_json(options={})
    super(
        :include => {
          :products => {
            :except => [:logo_id, :created_at, :updated_at]
          },
          :picture => {
              :except => [:created_at, :updated_at]
          }
        },
        :except => [:created_at, :updated_at]
    )
  end

end
