class ImdbMovie
  
  attr_accessor :id, :url, :title
  
  def initialize(id, title = nil)
    @id = id
    @url = "http://www.imdb.com/title/tt#{self.id}/"
    @title = title
  end
  
  def director
    document.at("h5[text()='Director:'] ~ a").innerHTML rescue 'Unknown'
  end
  
  def poster
    document.at("a[@name='poster'] img")['src']
  end
  
  private
  
  def document
    @document ||= Hpricot(open(self.url).read)
  end
  
end