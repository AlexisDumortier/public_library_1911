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

  def test_it_can_return_the_publication_years_for_an_author
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})  
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    assert_equal ["1847", "1853" ], charlotte_bronte.books_publication_year
  end

end