class RichterCatalogue::Painting
  attr_accessor :name, :medium, :year, :size, :price, :painting_url
  attr_reader :artist, :subject

  @@all = []
  @@names_all = []

  def initialize(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end


  def self.create_from_subject(paintings_array, subject = nil)
    paintings_array.each do |attributes_hash|
      new_painting = RichterCatalogue::Painting.new(attributes_hash)
      new_painting.subject = subject
    end
  end

  def add_attributes(attributes_hash)
    attributes_hash.each do |key, value|
        self.send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist
    artist.add_painting(self)
  end

  def subject=(subject)
    @subject = subject
    subject.add_painting(self)
  end

  def year=(year)
    @year = year
    year.add_painting(self)
  end

  def self.display_name(painting)
    puts "- #{painting.name}"
  end

  def self.display(painting)

    puts "  name: #{painting.name}"
    puts "  year: #{painting.year.name}"
    puts "  size: #{painting.size}"
    puts "  medium: #{painting.medium}"

    if !(painting.price == "")
      puts "  price: #{painting.price}"
    end
    puts "------------------------"
  end

  def self.names
    RichterCatalogue::Painting.all.collect {|painting| painting.name}.uniq
  end

  def self.find_by_name(name)
    self.all.select{|painting| painting.name == name}
  end

end