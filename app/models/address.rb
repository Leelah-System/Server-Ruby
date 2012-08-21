class Address < ActiveRecord::Base
  belongs_to :addressable,  :polymorphic => true

  attr_accessor :is_head_office

end
