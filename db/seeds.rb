require 'open-uri'

# Users creation
User.delete_all
nb_users = 0
open("http://doc.leelah-system.com/base/restaurant1/users.txt", "r:UTF-8") do |users|

  # Do not insert the first line
  users.readline

  users.read.each_line do |user|
    login, password, first_name, last_name, email, status = user.chomp.split(";")
    u = User.create(:login => login, :password => password, :first_name => first_name, :last_name => last_name, :email => email, :status => status)

    nb_users += 1 if u.errors.empty?

    # display errors
    u.errors.messages.each do |message|
      puts "User #{login}: #{message[0]}: #{message[1]}"
    end
  end
end
puts "Users created: #{nb_users} user(s)"

# Categories creation
Category.delete_all
nb_categories = 0
open("http://doc.leelah-system.com/base/restaurant1/categories.txt", "r:UTF-8") do |categories|

  # Do not insert the first line
  categories.readline

  categories.read.each_line do |category|
    id, label, name, description = category.chomp.split(";")
    c = Category.create(:id => id, :label => label, :name => name, :description => description) do |cat|
      # force ID assignment (http://stackoverflow.com/questions/6531385/how-can-i-store-the-object-id-in-a-migration-file)
      cat.id = id
    end

    nb_categories += 1 if c.errors.empty?

    # display errors
    c.errors.messages.each do |message|
      puts "Category #{name}: #{message[0]}: #{message[1]}"
    end

  end
end
puts "Categories created: #{nb_categories} categories"

# Products creation
Product.delete_all
nb_products = 0
open("http://doc.leelah-system.com/base/restaurant1/products.txt", "r:UTF-8") do |products|

  # Do not insert the first line
  products.readline

  products.read.each_line do |product|
    id, reference, label, name, description, price, stock, logo_id, category_id = product.chomp.split(";")
    p = Product.create(:id => id, :reference => reference, :label => label, :name => name, :description => description, :price => price, :stock => stock, :logo_id => logo_id, :category_id => category_id) do |pro|
      # force ID assignment (http://stackoverflow.com/questions/6531385/how-can-i-store-the-object-id-in-a-migration-file)
      pro.id = id
    end

    nb_products += 1 if p.errors.empty?

    # display errors
    p.errors.messages.each do |message|
      puts "Product #{reference}: #{message[0]}: #{message[1]}"
    end
  end
end
puts "Products created #{nb_products} products"