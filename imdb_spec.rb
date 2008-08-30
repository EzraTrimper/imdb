require 'imdb'

describe ImdbSearch do

  before(:each) do
    @imdb_search = ImdbSearch.new('Indiana Jones')
    @imdb_search.stub!(:open).and_return(open('sample_search.html'))
  end

  describe "movies" do

    it "should query IMDB url" do
      @imdb_search.should_receive(:open).with("http://www.imdb.com/find?s=all&q=Indiana+Jones").and_return(open('sample_search.html'))
      @imdb_search.movies
    end

    it "should be a collection of ImdbMovie instances" do
      @imdb_search.movies.should have(59).imdb_movies
    end

    it "should include 'Indiana Jones and the Last Crusade'" do
      @imdb_search.movies.detect { |m| m.title == 'Indiana Jones and the Last Crusade' }.should_not be_nil
    end

    it "should have titles (without HTML tags)" do
      @imdb_search.movies.each do |movie|
        movie.title.should_not be_empty
        movie.title.should_not match(/<.+>/)
      end
    end
  end

end