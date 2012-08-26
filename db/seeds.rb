require 'open-uri'

# Users creation
User.delete_all
nb_users = 0
open("http://doc.leelah-system.com/base/restaurant1/users.csv") do |users|
  users.read.each_line do |user|
    if nb_users == 0
      # Do not insert the first line
      nb_users += 1
    else
      login, password, first_name, last_name, email, status = user.chomp.split(";")
      user.create!(:login => login, :password => password, :first_name => first_name, :last_name => last_name, :email => email, :status => status)
      nb_users += 1
    end
  end
end
puts "Users created: #{users.size} user(s)"

# Categories creation
Category.delete_all
nb_categories = 0
open("http://doc.leelah-system.com/base/restaurant1/categories.csv") do |categories|
  categories.read.each_line do |category|
    if nb_categories == 0
      # Do not insert the first line
      nb_categories += 1
    else
      id, label, name, description = category.chomp.split(";")
      category.create!(:id => id, :label => label, :name => name, :description => description)
      nb_categories += 1
    end
  end
end
puts "Categories created: #{categories.size} categories"

# Products creation
Product.delete_all
nb_products = 0
open("http://doc.leelah-system.com/base/restaurant1/products.csv") do |products|
  products.read.each_line do |product|
    if nb_products == 0
      # Do not insert the first line
      nb_products += 1
    else
      id, reference, label, name, description, price, stock, logo_id, category_id = product.chomp.split(";")
      product.create!(:id => id, :reference => reference, :label => label, :name => name, :description => description, :price => price, :stock => stock, :logo_id => logo_id, :category_id => category_id)
      nb_products += 1
    end
  end
end
puts "Products created #{products.size} products"