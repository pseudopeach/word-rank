require './word_ranker.rb'

input = File.open(ARGV.first).read()
words = WordRanker.rank_words(input, 20, 4)
puts ""
puts "**** Word Rankings ****"

puts "WORD \t\t\t FREQUENCY"
words.each{|w| puts "#{w[:word]} \t\t\t #{w[:count]}" }
    
