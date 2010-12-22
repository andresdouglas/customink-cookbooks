# attributes can store arbitrary values
default["my_string"] = "this is a string"
default["my_integer"] = 42
default["my_array"] = ["one", "two", "three"]
default["my_hash"] = {"foo" => "bar", "bar" => "foo"}

# use dot notation to set a value, too
default.my_other_string = "this is another string"