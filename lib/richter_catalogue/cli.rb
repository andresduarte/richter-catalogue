class RichterCatalogue::CLI

  def call 
    search_method
    goodbye
  end

  def search_method
    input = nil 
    while input != "exit"
      puts "Welcome to Gerhard Richter's Catalogue"
      puts "Search by subject or by year?"
      input = gets.strip.downcase
      case input 
      when "subject"
        puts "List subjects"
      when "year"
        puts "lists years"
      end 
    end
  end

  def goodbye

end