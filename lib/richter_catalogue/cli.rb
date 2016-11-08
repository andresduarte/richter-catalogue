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

  def make_enviroment
    make_artists
    make_subjects
    make_paintings
    add_painting_attributes
  end

  def call 
    make_enviroment
    puts "Welcome to Gerhard Richter's Catalogue"
    search_method
    goodbye
  end

  def search_method(input = nil)
    input = nil 
    while input != "exit"
      puts "Search by subject or by year?"
      input = gets.strip.downcase
      case input 
      when "subject"
        list_subjects
        subject_paintings
      when "year"
        list_years
        year_paintings
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
    input_subject = nil 
    while input_subject != "exit"
      puts "Select subject by number or name"
      input_subject = gets.strip
      subject_names = RichterCatalogue::Subject.all.collect {|subject| subject.name}
      if input_subject.to_i.between?(1, subject_names.size + 1)
        subject_paintings_names(subject_names[input_subject.to_i - 1])
      elsif subject_names.include?(input_subject.capitalize)
        subject_paintings_names(input_subject.capitalize)
      else 
        puts "Subject is invalid, please try again"
        subject_paintings
      end 
    end 
  end 

  def subject_paintings_names(subject_name)
    input = nil
    while input != "exit"
      subject = RichterCatalogue::Subject.find_by_name(subject_name)
      painting_names = subject.paintings.collect {|painting| painting.name}
      painting_names.each.with_index(1) {|p, i| puts "#{i}. #{p}"}
      input = gets.strip
      if input.to_i.between?(1, painting_names.size + 1)
        RichterCatalogue::Painting.display(subject.paintings[input.to_i - 1]) 
      elsif !subject.paintings.detect {|painting| painting.name == input}.nil?
        paintings_matched = subject.paintings.select {|painting| painting.name == input.capitalize}
        paintings_matched.each {|painting| RichterCatalogue::Painting.display(painting)}
      else
        puts "Painting is invalid, please try again"
        subject_paintings_names(subject_name)
      end
    end
  end

  def year_paintings
    input_year = nil 
    while input_year != "exit"
      puts "Select a year"
      input_year = gets.strip
      if !RichterCatalogue::Year.find_by_name(input_year).nil?
        year_paintings_names(input_year)
      else
        puts "No paintings found for selected year please select another year"
        year_display
      end
    end
  end
    

  def year_paintings_names(year_name)
    input = nil
    while input != "exit"
      year = RichterCatalogue::Year.find_by_name(year_name)
      painting_names = year.paintings.collect {|painting| painting.name}
      painting_names.each.with_index(1) {|p, i| puts "#{i}. #{p}"}
      input = gets.strip
      if input.to_i.between?(1, painting_names.size + 1)
          RichterCatalogue::Painting.display(year.paintings[input.to_i - 1])
      elsif !subject.paintings.detect {|painting| painting.name == input}.nil?
        paintings_matched = year.paintings.select {|painting| painting.name == input.capitalize}
        paintings_matched.each {|painting| RichterCatalogue::Painting.display(painting)}
      else
        puts "Painting is invalid, please try again"
        subject_paintings_names(year_name)
      end
    end
  end

end