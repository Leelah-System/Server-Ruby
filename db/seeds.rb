# Users creation
User.delete_all

users = User.create([
  {:login => "thomas",  :password => "thomas",  :first_name => "Thomas",  :last_name => "Briois", :email => "tom.briois@gmail.com", :status => User::STATUS_ADMIN},
  {:login => "john",    :password => "john",    :first_name => "John",    :last_name => "Doe",    :email => "john.doe@gmail.com",   :status => User::STATUS_NONE}
])

puts "Users created: #{users.size} user(s)"
