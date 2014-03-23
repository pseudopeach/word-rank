require 'Set'

#doubly-linked list item representing all the words with a particular frequency
class FrequencyBucket
  attr_accessor :count, :higher, :lower, :words
  
  def initialize(word=nil)
    @count = 1
    @words = Set.new
    words.add(word) if word
  end
  
  # "moves" a word from [self] to a bucket with count 1 higher than [self.count], returns that word bucket
  def promote_word(word)
    new_count = count + 1
    if words.size == 1 && (!@higher || new_count < @higher.count)
      #this rank only has the one word, just bump it up by one
      @count = new_count
      return self # [word] is still in this frequncy bucket
    end
    
    if @higher && @higher.count == new_count
      #just add this word to the bucket directly above it
      @higher.words.add(word)
      new_bucket = @higher
    else
      #create a new bucket and insert it into the list, right above [self]
      new_bucket = FrequencyBucket.new(word)
      new_bucket.count = new_count
      new_bucket.higher = @higher
      new_bucket.lower = self
      @higher.lower = new_bucket if @higher
      @higher = new_bucket
    end
    
    words.delete(word)
    
    #clean this up if it's empty
    if @words.size == 0
      #unlink self
      @lower.higher = higher if lower
      @higher.lower = lower if higher
    end
    
    return new_bucket
  end
end