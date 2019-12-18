# ```ruby
# pry(main)> require './lib/author'
# #=> true

# pry(main)> charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})    
# #=> #<Author:0x00007fb898081850...>

# pry(main)> charlotte_bronte.name
# #=> "Charlotte Bronte"

# pry(main)> charlotte_bronte.books
# #=> []

# pry(main)> jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
# #=> #<Book:0x00007fb896e22538...>

# pry(main)> jane_eyre.class

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/author'


class AuthorTest < Minitest::Test

  def test_it_exists
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"}) 
    assert_instance_of Author, charlotte_bronte
  end

  def test_it_has_attributes
   charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"}) 
   assert_equal  "Charlotte Bronte", charlotte_bronte.name 
   assert_equal  [], charlotte_bronte.books
  end


  def test_that_author_can_write_books
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})  
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    assert_instance_of Book, jane_eyre 
    assert_equal [jane_eyre], charlotte_bronte.books
    villette = charlotte_bronte.write("Villette", "1853")
    assert_equal [jane_eyre, villette], charlotte_bronte.books
  end

end