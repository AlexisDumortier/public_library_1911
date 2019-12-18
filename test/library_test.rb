require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/author'
require_relative '../lib/library'


class LibraryTest < Minitest::Test

  def test_it_exists
    dpl = Library.new("Denver Public Library")
    assert_instance_of Library, dpl
  end

  def test_it_has_attributes
    dpl = Library.new("Denver Public Library")
    assert_equal "Denver Public Library", dpl.name
    assert_equal [], dpl.books
    assert_equal [], dpl.authors
    assert_equal [], dpl.checked_out_books
  end

  def test_it_can_add_authors
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")   
    professor = charlotte_bronte.write("The Professor", "1857")   
    villette = charlotte_bronte.write("Villette", "1853")   
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})  
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")   
    dpl.add_author(charlotte_bronte)

    assert_equal [charlotte_bronte], dpl.authors
    assert_equal [jane_eyre, professor, villette], dpl.books

    dpl.add_author(harper_lee)
    
    assert_equal [charlotte_bronte, harper_lee], dpl.authors
    assert_equal [jane_eyre, professor, villette, mockingbird], dpl.books
  end

  def test_it_can_return_the_publication_time_frame_for_a_give_author
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")   
    professor = charlotte_bronte.write("The Professor", "1857")   
    villette = charlotte_bronte.write("Villette", "1853")   
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})  
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")   
    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal ({:start=>"1847", :end=>"1857"}), dpl.publication_time_frame_for(charlotte_bronte)
    assert_equal ({:start=>"1960", :end=>"1960"}), dpl.publication_time_frame_for(harper_lee)
  end

  def test_it_can_check_out_books_if_they_exists_in_the_library_and_have_not_been_checked_out_yet
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960") 

    refute dpl.checkout(mockingbird)
    refute dpl.checkout(jane_eyre)
    
    dpl.add_author(charlotte_bronte)

    assert_equal true, dpl.checkout(jane_eyre)

    assert_equal [jane_eyre], dpl.checked_out_books

  end

  def test_books_can_be_returned
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"}) 
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"}) 
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960") 
    dpl.add_author(harper_lee)
    dpl.checkout(mockingbird)
    assert_equal [mockingbird], dpl.checked_out_books
    dpl.return(mockingbird)
    refute mockingbird.checked_out
    assert_equal [], dpl.checked_out_books
  end

  def test_it_can_log_how_many_times_a_book_has_been_checked_out
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"}) 
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"}) 
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960") 
    dpl.add_author(harper_lee)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    assert_equal 3, dpl.check_out_count[mockingbird]
  end  

  def test_it_can_return_the_most_popular_book
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"}) 
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"}) 
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960") 
    dpl.add_author(harper_lee)
    dpl.add_author(charlotte_bronte)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    assert_equal mockingbird, dpl.most_popular_book
    dpl.checkout(jane_eyre)
    dpl.return(jane_eyre)
    dpl.checkout(jane_eyre)
    dpl.return(jane_eyre)
    dpl.checkout(jane_eyre)
    dpl.return(jane_eyre)
    assert_equal mockingbird, dpl.most_popular_book
    dpl.checkout(jane_eyre)
    assert_equal jane_eyre, dpl.most_popular_book
  end

end
