class RichterCatalogue::CLI

  BASE_PATH = "https://www.gerhard-richter.com"

  def make_artists
    attributes_hash = RichterCatalogue::Scraper.artist_page("https://en.wikipedia.org/wiki/Gerhard_Richter")
    RichterCatalogue::Artist.create_from_profile(attributes_hash)
  end

  def make_subjects
    subjects_array = RichterCatalogue::Scraper.subjects_page(BASE_PATH + "/en/art/paintings")
    RichterCatalogue::Subject.create_from_subjects(subjects_array)
  end

  def make_paintings
    RichterCatalogue::Subject.all.each do |subject|
      paintings_array = RichterCatalogue::Scraper.subject_page(BASE_PATH + subject.subject_url)
      RichterCatalogue::Painting.create_from_subject(paintings_array, subject)
    end
  end

  def add_painting_attributes
    RichterCatalogue::Painting.all.each do |painting|
      attributes = RichterCatalogue::Scraper.painting_page(BASE_PATH + painting.painting_url)
      painting.add_attributes(attributes)
      painting.artist = RichterCatalogue::Artist.find_by_name("Gerhard Richter")
    end
  end

  def make_catalogue
    make_artists
    make_subjects
    make_paintings
    add_painting_attributes
  end

  def call 
    puts "Retrieving information from the Catalogue..."
    make_catalogue
    search_method
    goodbye
  end

  def search_method(input = nil)
    if input == "exit"
    else

      puts "Welcome to Gerhard Richter's Catalogue"
      puts "Search by subject, by year, or by name?"
      puts "type exit to exit"

      input = gets.strip.downcase
      
      case input 
      when "subject"
        list_subjects
        subject_paintings
      when "year"
        list_years
        year_paintings
      when "name"
        name_paintings
      when "exit"
        search_method("exit")
      else
        puts "Search method is invalid, please try again"
        search_method
      end 
    end
  end

  def goodbye
    puts "Thank you for visiting Gerhard Richter's Catalogue"
  end

  def list_subjects
    RichterCatalogue::Subject.all.each_with_index {|subject, i| puts "  #{i + 1}. #{subject.name}"}
  end 

  def list_years
    years = []
    RichterCatalogue::Year.all.each {|year, i| years << year.name}
    years = years.sort
    years.each {|year| puts " - #{year}"}
  end

  def subject_paintings

    subject_names = RichterCatalogue::Subject.all.collect {|subject| subject.name}
    subject_names_downcase = RichterCatalogue::Subject.all.collect {|subject| subject.name.downcase}

    puts "Select subject by number or by name"
    puts "type back to go back"
    puts "type exit to exit"

    input_subject = gets.strip

    if input_subject.to_i.between?(1, subject_names.size)
      subject_paintings_names(subject_names[input_subject.to_i - 1])
    elsif subject_names.include?(input_subject) || subject_names_downcase.include?(input_subject)
      if subject_names.include?(input_subject)
        subject_paintings_names(input_subject)
      else
        subject_paintings_names(subject_names[subject_names_downcase.index(input_subject)])
      end
    elsif input_subject == "back"
      search_method
    elsif input_subject == "exit"
      search_method("exit")
    else 
      puts "Subject is invalid, please try again"
      subject_paintings
    end 
  end 

  def subject_paintings_names(subject_name)

    subject = RichterCatalogue::Subject.find_by_name(subject_name)
    painting_names = subject.paintings.collect {|painting| painting.name}
    painting_names_downcase = subject.paintings.collect {|painting| painting.name.downcase}
    painting_names.each.with_index(1) {|p, i| puts "#{i}. #{p}"}

    puts "Select painting by number or by name"
    puts "type all to see information on all paintings"
    puts "type back to go back"
    puts "type exit to exit"

    input = gets.strip

    if input.to_i.between?(1, painting_names.size)
      RichterCatalogue::Painting.display(subject.paintings[input.to_i - 1])
      subject_paintings_names(subject_name) 
    elsif painting_names.include?(input) || painting_names_downcase.include?(input)
      if painting_names.include?(input)
        paintings_matched = subject.paintings.select {|painting| painting.name == input}
      else
        paintings_matched = subject.paintings.select {|painting| painting.name == painting_names[painting_names_downcase.index(input)]}
      end
      paintings_matched.each {|painting| RichterCatalogue::Painting.display(painting)}
      subject_paintings_names(subject_name)
    elsif input == "all"
      subject.paintings.each {|painting| RichterCatalogue::Painting.display(painting)}
      subject_paintings_names(subject_name)
    elsif input == "back"
      list_subjects
      subject_paintings
    elsif input == "exit"
      search_method("exit")
    else
      puts "Painting is invalid, please try again"
      subject_paintings_names(subject_name)
    end
  end

  def year_paintings

      puts "Select a year"
      puts "type back to go back"
      puts "type exit to exit"

      input_year = gets.strip

      if !RichterCatalogue::Year.find_by_name(input_year).nil?
        year_paintings_names(input_year)
      elsif input_year == "back"
        search_method
      elsif input_year == "exit"
        search_method("exit")
      else
        puts "No paintings found for selected year please select another year"
        year_paintings
      end
  end
    

  def year_paintings_names(year_name)

    year = RichterCatalogue::Year.find_by_name(year_name)
    painting_names = year.paintings.collect {|painting| painting.name}
    painting_names_downcase = year.paintings.collect {|painting| painting.name.downcase}
    painting_names.each.with_index(1) {|p, i| puts "#{i}. #{p}"}

    puts "Select painting by number or by name"
    puts "type all to see information on all paintings"
    puts "type back to go back"
    puts "type exit to exit"

    input = gets.strip

    if input.to_i.between?(1, painting_names.size)
      RichterCatalogue::Painting.display(year.paintings[input.to_i - 1])
      year_paintings_names(year_name)
    elsif painting_names.include?(input) || painting_names_downcase.include?(input)
      if painting_names.include?(input)
        paintings_matched = year.paintings.select {|painting| painting.name == input}
      else
        paintings_matched = year.paintings.select {|painting| painting.name == painting_names[painting_names_downcase.index(input)]}
      end
      paintings_matched.each {|painting| RichterCatalogue::Painting.display(painting)}
      year_paintings_names(year_name)
    elsif input == "all"
      year.paintings.each {|painting| RichterCatalogue::Painting.display(painting)}
      year_paintings_names(year_name)
    elsif input == "back"
      list_years
      year_paintings
    elsif input == "exit"
      search_method("exit")
    else
      puts "Painting is invalid, please try again"
      year_paintings_names(year_name)
    end
  end

  def name_paintings

    painting_names = RichterCatalogue::Painting.all.collect {|painting| painting.name}
    painting_names_downcase = RichterCatalogue::Painting.all.collect {|painting| painting.name.downcase}

    puts "type name"
    puts "type back to go back"
    puts "type exit to exit"

    input_name = gets.strip
    
    if painting_names.include?(input_name) || painting_names_downcase.include?(input_name) 
      if painting_names.include?(input_name)
        RichterCatalogue::Painting.find_by_name(input_name).each {|painting| RichterCatalogue::Painting.display(painting)}
      else
        RichterCatalogue::Painting.find_by_name(painting_names[painting_names_downcase.index(input_name)]).each {|painting| RichterCatalogue::Painting.display(painting)}
      end
      name_paintings
    elsif input_name == "back"
      search_method
    elsif input_name == "exit"
      search_method("exit")
    else 
      puts "Painting was not found please try again"
      name_paintings
    end
  end
    
end

