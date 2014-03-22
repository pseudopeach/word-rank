
  cases = [
    {args:["Row, row, row your boat, gently down the stream. BOAT!", 2], output: "row 3 boat 2" },
    {args:["Row, row, row your boat, gently down the stream. BOAT!", 1], output: "row 3" },
    {args:["a b c d a b c a b a", 100], output: "a 4 b 3 c 2 d 1" },
    {args:["", 10], output: "" },
    
  ] 
  
  cases.each do |tcase|
    name = tcase[:args].first
    begin
      word_counts = WordRanker.rank_words(name, tcase[:args].last).flatten.join(" ")
      result = (word_counts == tcase[:output]) ? "PASS" : "FAIL: Wrong answer: #{word_counts}"
    rescue Exception => e
      result = "FAIL: Error: #{e.inspect}"
    end
   puts "***CASE " + name
   puts result
   puts ""
  end
