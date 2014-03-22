require 'Set'

#doubly-linked list item representing all the words with a particular frequency
class WordFrequency
  attr_accessor :count, :higher, :lower, :words
  
  def initialize(word=nil)
    @count = 1
    @words = Set.new
    words.add(word) if word
  end
  
  # "moves" a word from [self] to a rank with count 1 higher than [count], returns that rank object
  def promote_word(word)
    new_count = count + 1
    if words.size == 1 && (!@higher || new_count < @higher.count)
      #this rank only has the one word, just bump it up by one
      @count = new_count
      return self
    end
    
    if @higher && @higher.count == new_count
      #just add this word to the rank above it
      @higher.words.add(word)
      new_rank = @higher
    else
      #create a new WordRank and insert it into the list
      new_rank = WordFrequency.new(word)
      new_rank.count = new_count
      new_rank.higher = @higher
      new_rank.lower = self
      @higher.lower = new_rank if @higher
      @higher = new_rank
    end
    
    words.delete(word)
    
    #clean this up if it's empty
    if @words.size == 0
      #unlink self
      @lower.higher = higher if lower
      @higher.lower = lower if higher
    end
    
    return new_rank
  end
end