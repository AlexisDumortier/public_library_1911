class Library

  attr_reader :name, :books, :authors, :checked_out_books, :check_out_count

  def initialize(name) 
    @name = name 
    @books = []
    @authors = []
    @checked_out_books = []
    @check_out_count = Hash.new(0)
  end 

  def add_author(author)
    @authors << author  
    @books << author.books
    @books = @books.flatten
  end

  def publication_time_frame_for(author)
    {:start=> author.books_publication_year.min, :end=> author.books_publication_year.max}
  end

  def checkout(book)
    return false if !books.include?(book) 

    if !book.checked_out 
      book.checked_out = true
      @checked_out_books << book
      check_out_log(book)
      true
    else
      false
    end
  end

  def return(book)
    book.checked_out = false    
    checked_out_books.delete_at(checked_out_books.index(book))
  end

  def check_out_log(book)
    @check_out_count[book] += 1
    # if !@check_out_count[book]
    #   @check_out_count[book] = 1
    # else
    #   @check_out_count[book] += 1
    # end
  end

  def most_popular_book
    result = @check_out_count.max_by{|book,count| count}
    result[0]
  end
  
end