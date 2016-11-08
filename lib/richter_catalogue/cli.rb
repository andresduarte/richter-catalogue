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
      else
        puts "Search method is invalid, please try again"
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
    input = nil 
    while input != "exit"
      puts "Select subject by number or name"
      input_subject = gets.strip
      case input_subject
      when "1", "aeroplanes", "Aeroplanes"
        subject_paintings_names("Aeroplanes")
      when "2", "Children", "children"
        subject_paintings_names("Children")
      when "3", "Families", "families"
        subject_paintings_names("Families")
      when "4", "Flowers", "flowers"
        subject_paintings_names("Flowers")
      when "5", "Mother and Child", "mother and child", "Mother and child"
        subject_paintings_names("Mother and Child")
      when "6", "Skulls", "skulls"
        subject_paintings_names("Skulls")
      when "back"
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
        #RichterCatalogue::Painting.find_by_name(painting_names[input.to_i - 1]).each {|painting| RichterCatalogue::Painting.display(painting)}
      elsif !subject.paintings.detect {|painting| painting.name == input.capitalize}.nil?
        paintings_matched = subject.paintings.select {|painting| painting.name == input.capitalize}
        paintings_matched.each {|painting| RichterCatalogue::Painting.display(painting)}
      elsif input == "exit"
        search_method("exit")
      else
        puts "Painting is invalid, please try again"
        subject_paintings_names(subject_name)
      end
    end
  end

end