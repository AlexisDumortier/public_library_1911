class Book

attr_reader :title, :author, :publication_year
attr_accessor :checked_out

  def initialize(book_attributes) 
    @title = book_attributes[:title] 
    @author = book_attributes[:author_first_name] + " " + book_attributes[:author_last_name]
    @publication_year = book_attributes[:publication_date][-4..-1]
    @checked_out = false
  end 
  
end