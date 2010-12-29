#
# Cookbook Name:: learning_chef
# Recipe:: default
#
# Copyright 2010, CustomInk, LLC
#
# All rights reserved - Do Not Redistribute
#

# set a vaule in the recipe
node.set.recipe.my_attribute = "this attribute was set in the recipe file"

# only set if it's not already set
node.set_unless[:my_string] = "this was set in the recipe using set_unless"

# the recipe has higher precedence than the attribute file
node.set.my_integer = 56

# it is easy to add to an attribute in a recipe
node.my_array.push("an additional item, added by the recipe file")

# adding to a hash is easy enough
node.override.my_hash = node.my_hash.merge({"something" => "else"})

# but merging like this yields unexpected results
node.my_hash.merge!({"something" => "else"})

node.override.my_hash =  node.my_hash.merge({"something1" => "else1"})


template "/tmp/attribute.txt" do
  mode "0777"
  source "attribute_value.erb"
end
