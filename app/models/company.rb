class Company < ActiveRecord::Base
  belongs_to  :head_office,  :class_name => "Address"
  has_many    :contacts,  :as => :contactable,          :dependent => :destroy
  has_many    :addresses, :as => :addressable,          :dependent => :destroy
  has_one     :picture,   :as => :imageable

  accepts_nested_attributes_for :addresses, :contacts, :picture


  before_validation :select_head_office


  JSON_WITH_ALL = {
      :include => [:head_office, :addresses, :contacts, :picture]
  }

  def as_json(options={})
    super(JSON_WITH_ALL)
  end

  protected

  def select_head_office

    self.addresses.each do |address|

      if address.is_head_office
        self.head_office = address
      end

    end

  end

end
