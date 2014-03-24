require './word_ranker.rb'

input = File.open(ARGV.first).read()
words = WordRanker.rank_words(input, 20, 4)
puts ""
puts "**** Word Rankings ****"

puts "WORD \t\t\t FREQUENCY"
#formats console output in proper columns
words.each {|w| printf "%-25s %d\n" % ["#{w[:word]}", "#{w[:count]}"] }
    
