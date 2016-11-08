class RichterCatalogue::Year
  attr_accessor :name, :paintings
  @@all = []

  def initialize(name)
    @name = name
    @paintings = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    new_year = RichterCatalogue::Year.new(name)
    self.all << new_year
    new_year
  end

  def add_painting(painting)
    painting.artist = self unless painting.artist == self
    @paintings << painting unless @paintings.include?(painting)
  end

  def self.find_by_name(name)
    self.all.detect{|obj| obj.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

end