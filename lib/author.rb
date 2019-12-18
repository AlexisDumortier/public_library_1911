require_relative '../lib/book'

class Author

  attr_reader :name, :books

  def initialize(author_attributes) 
   @first_name = author_attributes[:first_name] 
   @last_name = author_attributes[:last_name]
   @name = @first_name + " " + @last_name
   @books = []
  end 

  def write(title, publication_date)
    book_attributes = {author_first_name: @first_name, author_last_name: @last_name, title: title, publication_date: publication_date }
    book = Book.new(book_attributes)
    books << book
    book
  end

  def books_publication_year
    @books.map {|book| book.publication_year}
  end    

end