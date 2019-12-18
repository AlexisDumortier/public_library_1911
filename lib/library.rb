class Library

  attr_reader :name, :books, :authors

  def initialize(name) 
    @name = name 
    @books = []
    @authors = []
  end 

  def add_author(author)
    @authors << author  
    @books << author.books
    @books = @books.flatten
  end

  def publication_time_frame_for(author)
    {:start=> author.books_publication_year.min, :end=> author.books_publication_year.max}
  end
  
end