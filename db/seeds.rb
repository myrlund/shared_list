# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.delete_all
user = User.create(:username => "jonas", :password => "passord", :password_confirmation => "passord", :email => "myrlund@gmail.com")
foo = User.create(:username => "foo", :password => "passord", :password_confirmation => "passord", :email => "foo@bar.com")

List.delete_all
list = List.new(:title => "Testliste", :description => "Beskrivelse som er skikkelig lang lizm.")
list.owner = user
list.save

subscribed = List.new(:title => "Subscribed list", :description => "A subscribed list.")
subscribed.owner = foo
subscribed.save
subscribed.subscriptions.create(:user => user)

nonsubscribed = List.new(:title => "Unsubscribed list", :description => "An unsubscribed list.")
nonsubscribed.owner = foo
nonsubscribed.save

Item.delete_all
1.upto(5) do |n|
  item = list.items.new(:title => "Item number #{n}")
  item.user = user
  item.save
end

Role.delete_all
[:read, :write, :manage].each do |role_symbol|
  Role.create(:title => role_symbol.to_s)
end

# Make foo a subscriber to the list
list.subscriptions.create(:user => foo)
