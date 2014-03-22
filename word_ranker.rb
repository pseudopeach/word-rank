require './word_frequency.rb'

class WordRanker
  
  def initialize
    @index = {}
    @highest = @lowest = WordFrequency.new
  end
  
  def record(word)
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