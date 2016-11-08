class RichterCatalogue::Subject
  attr_accessor :name, :subject_url, :paintings, :artists
  @@all = []

  def initialize
    @@all << self
    @paintings = []
  end

  def self.all
    @@all
  end

  def self.create_from_subjects(subjects_array)
    subjects_array.each do |subject_hash|
      new_subject = RichterCatalogue::Subject.new
      subject_hash.each do |key, value|
        new_subject.send("#{key}=", value)
      end
    end
  end

  def artists
    self.paintings.collect {|painting| painting.artist}.uniq
  end

  def add_painting(painting)
    painting.artist = self unless painting.artist == self
    @paintings << painting unless @paintings.include?(painting)
  end

  def self.find_by_name(name)
    self.all.detect{|subject| subject.name == name}
  end

end