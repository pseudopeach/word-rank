require './word_frequency.rb'

class WordRanker
  attr_accessor :min_size
  
  def initialize
    @index = {}
    @highest = @lowest = FrequencyBucket.new
    @min_size = 1
  end
  
  def self.rank_words(text, n, min_size=1)
    ranker = WordRanker.new
    ranker.min_size = min_size
    text.split(/\W+/).each{|w| ranker.record w}
    ranker.top_words(n)
  end
  
  #inserts or updates a word in the collection
  def record(word)
    return if word.length < @min_size
    word = word.downcase
    
    if item = @index[word]
      #the word is located in the bucket [item]
      new_bucket = item.promote_word(word)
      @index[word] = new_bucket
      @highest = new_bucket if item == @highest
    else  
      insert(word)
    end
  end 
  
  #inserts a word as new
  def insert(word)
    if @lowest && @lowest.count == 1
      @lowest.words.add(word)
    else
      #update list tail
      item = FrequencyBucket.new(word)
      @lowest.lower = item
      item.higher = @lowest
      @lowest = item
    end
    #add [word] to the bucket index
    @index[word] = @lowest
  end
  
  #gets the top ranked words in the index, limited to [limit] words
  def top_words(limit)
    words = []
    count = 0
    current_bucket = @highest
    begin
      current_bucket.words.each do |word|
        words << {word:word, count:current_bucket.count}
        count += 1
        return words if count == limit
      end
    end while(current_bucket = current_bucket.lower)
    
    return words
  end 
end