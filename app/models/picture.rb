class Picture < ActiveRecord::Base

  belongs_to  :imageable, :polymorphic => true

  attr_accessor :data_picture


  before_save :save_image

  def save_image
      if (self.data_picture)
        binary_data = Base64.decode64(self.data_picture)

        filename  = self.label + "-" + rand(10000..99999).to_s
        self.path = "pictures/" + self.imageable_type.downcase.pluralize + "/" + filename + ".png"

        file = File.open("public/" + self.path, "wb+")
        file.write(binary_data)
        file.close
      end
  end

end
