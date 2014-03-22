require './word_frequency.rb'

class WordRanker
  attr_accessor :min_size
  
  def initialize
    @index = {}
    @highest = @lowest = WordFrequency.new
    @min_size = 1
  end
  
  def self.rank_words(text, n, min_size=1)
    ranker = WordRanker.new
    ranker.min_size = min_size
    text.split(/\W+/).each{|w| ranker.record w}
    ranker.top_words(n)
  end
  
  def record(word)
    return if word.length < @min_size
    word = word.downcase
    
    if item = @index[word]
      new_rank = item.promote_word(word)
      @index[word] = new_rank
      @highest = new_rank if item == @highest
    else  
      insert(word)
    end
  end 
  
  def insert(word)
    if @lowest && @lowest.count == 1
      @lowest.words.add(word)
    else
      #update list tail
      item = WordFrequency.new(word)
      @lowest.lower = item
      item.higher = @lowest
      @lowest = item
    end
    @index[word] = @lowest
  end
  
  def top_words(limit)
    words = []
    count = 0
    current_rank = @highest
    begin
      current_rank.words.each do |word|
        words << word
        count += 1
        return words if count == limit
      end
    end while(current_rank = current_rank.lower)
    
    return words
  end 
end